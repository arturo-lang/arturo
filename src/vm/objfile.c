/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/objfile.c
 *****************************************************************/

#include "arturo.h"

/**************************************
  Helpers
 **************************************/

#define getNextByte() 	*buffer++
#define getNextWord() 	(*(buffer+0) << 0 | *(buffer+1) << 8); buffer+=2
#define getNextDword()	(*(buffer+0) << 0 	| *(buffer+1) << 8 | \
 						 *(buffer+2) << 16  | *(buffer+3) << 24); buffer+=4

/**************************************
  Methods
 **************************************/

void writeObjFile(const char* filename) {
	//-------------------------------------------
	// Open file for writing (binary mode)
	//-------------------------------------------

	FILE* fp = fopen(filename, "wb");  

	//-------------------------------------------
	// Write header
	//-------------------------------------------

	Byte version = 0;											
	fwrite(&version, sizeof(Byte), 1, fp);						// 1 byte  : version
	Byte subvers = 8;
	fwrite(&subvers, sizeof(Byte), 1, fp);						// 1 byte  : subversion
	
	//-------------------------------------------
	// Write data
	//-------------------------------------------

	int dataSize = BData->size;
	fwrite(&dataSize, sizeof(int), 1, fp);						// 2 bytes : BData->size

	aEach(BData,i) {											// Loop @BData
		Byte kind = Kind(BData->data[i]);
		fwrite(&kind, sizeof(Byte), 1, fp);						// 1 byte  : data kind

		switch (kind) {
			case IV: {		
				Int32 val = I(BData->data[i]);
				fwrite(&val, sizeof(Int32), 1, fp); 			// 4 bytes -> Int32
				break;
			}
			case SV: {
				int sz = S(BData->data[i])->size;
				fwrite(&sz, sizeof(int), 1, fp);				// 4 bytes -> String size

				char* str = S(BData->data[i])->content;
				fwrite(str, sizeof(char), sz, fp); 				// X bytes -> String
				break;
			}
			default: {
				printf("whatever...\n");
			}
		}
	}

	//-------------------------------------------
	// Write bytecode
	//-------------------------------------------

	aEach(BCode,j) {
		fwrite(&(BCode->data[j]), sizeof(Byte), 1, fp);			// 1 byte -> byte-op
	}

	//-------------------------------------------
	// Close file
	//-------------------------------------------

	fclose(fp);
}

void readObjFile(const char* filename) {
	//-------------------------------------------
	// Read whole file into buffer
	//-------------------------------------------
	
	FILE *f = fopen(filename, "rb");
	
	fseek(f, 0, SEEK_END);
	long fsize = ftell(f);
	fseek(f, 0, SEEK_SET);

	char *buffer = malloc(fsize + 1);
	fread(buffer, 1, fsize, f);
	
	fclose(f);
	
	//-------------------------------------------
	// Initialize data structures
	//-------------------------------------------

	BCode 			= aNew(Byte, INITIAL_BCODE_SIZE);
	BData 			= aNew(Value, INITIAL_BDATA_SIZE);

	//-------------------------------------------
	// Read header
	//-------------------------------------------

	Byte version = getNextByte();
	Byte subvers = getNextByte();

	//-------------------------------------------
	// Read data
	//-------------------------------------------

	int dataSize = getNextDword();

	for (int j=0; j<dataSize; j++) {
		Byte kind = getNextByte();

		switch (kind) {
			case IV: {
				Int32 val = getNextDword();
				
				storeValueData(toI(val));
				break;
			}
			case SV: {
				int sz = getNextDword();

				char* str = malloc(sz+1);
				memcpy(str,buffer,sz+1);
				buffer += sz;
				storeValueData(strToStringValue(str));
				free(str);
				break;
			}
			default: {

			}
		}
	}

	//-------------------------------------------
	// Read bytecode
	//-------------------------------------------

	Byte next = getNextByte();
	while (true) { 
		aAdd(BCode,next);
		if (next==END) {
			break;
		}
		next = getNextByte();
	}
}
