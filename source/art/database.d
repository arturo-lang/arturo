/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/database.d
 *****************************************************************/

module art.database;

// Imports

import etc.c.sqlite3;

import std.array;
import std.conv;
import std.random;
import std.stdio;
import std.string;
import std.uuid;
import std.variant;

import parser.expressions;

import value;

import func;
import globals;

import panic;

// Constants

enum _ID										= "_id";
enum _TYPE                                      = "_type";
enum _OBJECT                                   	= "_object";
enum _PATH 										= ":path";

const string[] SQLITE_RESULTSTR =
[
	"Successful",
	"SQL error or missing database",
	"Internal logic error in SQLite",
	"Access permission denied",
	"Callback routine requested an abort",
	"The database file is locked",
	"A table in the database is locked",
	"A malloc() failed",
	"Attempt to write a readonly database",
	"Operation terminated by sqlite3_interrupt()",
	"Some kind of disk I/O error occured",
	"The database disk image is malformed",
	"Unknown opcode in sqlite3_file_control()",
	"Insertion failed because database is full",
	"Unable to open the database file",
	"Database lock protocol error",
	"Database is empty",
	"The database schema changed",
	"String or BLOB exceeds size limit",
	"Abort due to constraint violation",
	"Data type mismatch",
	"Library used incorrectly",
	"Uses OS features not supported on host",
	"Authorization denied",
	"Auxiliary database format error",
	"2nd parameter to sqlite3_bind out of range",
	"File opened that is not a database file",
	"Notifications from sqlite3_log()",
	"Warnings from sqlite3_log()"
];

const string SQLITE_DBNOTINITIALIZED = "Database has not been initialized";
const string SQLITE_CURRENTSTATEMENTISNULL = "Current statement is null";

// Utilities

string getUUID() {
    Xorshift192 gen;

    gen.seed(unpredictableSeed);
    auto genUuid = randomUUID(gen);

    return genUuid.toString();
}


Value closeDatabase(sqlite3* db) {
	int result = sqlite3_close(db);

	if (result==SQLITE_OK) return new Value(true);
	else throw new ERR_DatabaseError(SQLITE_RESULTSTR[result]);
}

Value queryDatabase(sqlite3* db, string query) {
	sqlite3_stmt* stmt;
	sqlite3_prepare(db, toStringz(query), cast(int)(query.length), &stmt, null);

	int result = sqlite3_step(stmt);

	if (result==SQLITE_OK || result==SQLITE_DONE) {
		return Value.dictionary();
	}
	else if (result==SQLITE_ROW) {
		Value[] ret;
		while (result==SQLITE_ROW) {
      		Value dict = Value.dictionary();

      		int numCols = sqlite3_data_count(stmt);

         	for (int i=0; i<numCols; i++)
         	{
            	string val = to!string(sqlite3_column_text(stmt,i));
            	string col = to!string(sqlite3_column_name(stmt,i));

            	dict[col] = new Value(val);
         	}
         	
         	result = sqlite3_step(stmt);


         	if (!((result==SQLITE_DONE)||(result==SQLITE_ROW)))
	      		throw new ERR_DatabaseError(SQLITE_RESULTSTR[result]);

	      	ret ~= dict;
		}

		return new Value(ret);
	}
	else throw new ERR_DatabaseError(SQLITE_RESULTSTR[result]);
}

Value openOrCreateDatabase(string path, bool open=false) {
	sqlite3* db;
	int result;

	if (open) result = sqlite3_open_v2(toStringz(path~".db"), &db, SQLITE_OPEN_READWRITE, null);
	else result = sqlite3_open_v2(toStringz(path~".db"), &db, SQLITE_OPEN_CREATE, null);

	if (result==SQLITE_OK) 
	{
		Value obj = Value.dictionary();
		obj[_PATH] = new Value(path);
		obj[_OBJECT] = new Value(cast(void *)db);
		obj[_ID] = new Value(getUUID());
		obj[_TYPE] = new Value("database");

		obj["close"] = new Value(new Func((Value vs){ 
			sqlite3* db = cast(sqlite3*)obj["_object"].content.o;
			
			return closeDatabase(db);
		}));

		obj["query"] = new Value(new Func((Value vs){
			sqlite3* db = cast(sqlite3*)obj["_object"].content.o;
			string query  = vs.content.a[0].content.s;

			return queryDatabase(db,query);
		}));

		return obj;
	}
	else throw new ERR_DatabaseError(SQLITE_RESULTSTR[result]);
}

// Functions

class Database__Create_ : Func {
	this(string ns="") { super(ns ~ "create","create new SQLite database using path",[[sV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		return openOrCreateDatabase(path,false);
	}
}

class Database__Open_ : Func {
	this(string ns="") { super(ns ~ "open","open SQLite database using path",[[sV]],[dV]); }
	override Value execute(Expressions ex, string hId=null) {
		Value[] v = validate(ex);
		alias path = S!(v,0);

		return openOrCreateDatabase(path,true);
	}
}
