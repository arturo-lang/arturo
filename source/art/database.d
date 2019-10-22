/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: art/database.d
 *****************************************************************/

module art.database;

version(SQLITE) {

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

	import func;
	import globals;
	import panic;
	import value;

	// Constants

	enum _ID										= "_id";
	enum _TYPE                                      = "_type";
	enum _OBJECT                                   	= "_object";
	enum _TITLE										= ":title";
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

		if (result==SQLITE_OK) return TRUEV;
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

	Value createDatabaseTable(sqlite3* db, string title, Value fields) {
		string query = "CREATE TABLE " ~ title ~ " (";
		string[] items;
		foreach (string key, Value val; fields.dictionaryKeyValues(true)) {
			string currentField = "";
			currentField ~= key ~ " ";
			if (val.type==sV) {
				currentField ~= val.content.s;
			}
			else if (val.type==aV) {
				currentField ~= val.content.a[0].content.s;
			}
			items ~= currentField;
		}
		query ~= items.join(",");
		query ~= ");";
		return queryDatabase(db,query);
	}

	Value insertIntoDatabase(sqlite3* db, string title, Value fields) {
		string query = "INSERT INTO " ~ title ~ " (";
		string[] items;
		foreach (string key, Value val; fields.dictionaryKeyValues(true)) {
			items ~= key;
		}
		query ~= items.join(",");
		query ~= ") VALUES (";

		items = [];
		foreach (string key, Value val; fields.dictionaryKeyValues(true)) {
			if (val.type==sV) {
				items ~= "'" ~  val.content.s ~ "'";
			}
			else if (val.type==nV) {
				items ~= to!string(val.content.i);
			}
		}
		query ~= items.join(",");
		query ~= ");";

		return queryDatabase(db,query);
	}

	Value openOrCreateDatabase(string path, bool open=false) {
		sqlite3* db;
		int result;

		if (open) result = sqlite3_open_v2(toStringz(path~".db"), &db, SQLITE_OPEN_READWRITE, null);
		else result = sqlite3_open_v2(toStringz(path~".db"), &db, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE, null);

		if (result==SQLITE_OK) 
		{
			Value obj = Value.dictionary();
			obj[_PATH] = new Value(path);
			obj[_OBJECT] = new Value(cast(void *)db);
			obj[_ID] = new Value(getUUID());
			obj[_TYPE] = new Value("database");

			obj["close"] = new Value(new Func((Value vs){ 
				sqlite3* db = cast(sqlite3*)obj[_OBJECT].content.o;
				
				return closeDatabase(db);
			}));

			obj["query"] = new Value(new Func((Value vs){
				sqlite3* db = cast(sqlite3*)obj[_OBJECT].content.o;
				string query  = vs.content.a[0].content.s;

				return queryDatabase(db,query);
			}));

			obj["createTable"] = new Value(new Func((Value vs){
				sqlite3* db = cast(sqlite3*)obj[_OBJECT].content.o;

				string title = vs.content.a[0].content.s;
				Value fields = vs.content.a[1];

				obj[title] = Value.dictionary();
				obj[title]["add"] = new Value(new Func((Value vs){ 
					sqlite3* db = cast(sqlite3*)obj[_OBJECT].content.o;

					Value fields = vs.content.a[0];
				
					return insertIntoDatabase(db,title,fields);
				}));

				return createDatabaseTable(db,title,fields);
			}));

			return obj;
		}
		else throw new ERR_DatabaseError(SQLITE_RESULTSTR[result]);
	}

	// Functions

	final class Database__Create_ : Func {
		this(string ns="") { super(ns ~ "create","create new SQLite database using path",[[sV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			alias path = S!(v,0);

			return openOrCreateDatabase(path,false);
		}
	}

	final class Database__Open_ : Func {
		this(string ns="") { super(ns ~ "open","open SQLite database using path",[[sV]],[dV]); }
		override Value execute(Expressions ex, string hId=null) {
			Value[] v = validate(ex);
			alias path = S!(v,0);

			return openOrCreateDatabase(path,true);
		}
	}
}
