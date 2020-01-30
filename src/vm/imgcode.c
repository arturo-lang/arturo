/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/vm/imgcode.c
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

void writeImgFile(const char* filename) {
	//-------------------------------------------
	// Open file for writing (binary mode)
	//-------------------------------------------

	FILE* fp = tmpfile();  

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
			case FV: {
				Dword ip = F(BData->data[i])->ip;
				fwrite(&ip, sizeof(Dword), 1, fp);

				ip = F(BData->data[i])->to;
				fwrite(&ip, sizeof(Dword), 1, fp);

				Byte args = F(BData->data[i])->args;
				fwrite(&args, sizeof(Byte), 1, fp);
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
	// Read buffer back
	//-------------------------------------------

	rewind(fp);

	fseek(fp, 0, SEEK_END);
	long fsize = ftell(fp);
	fseek(fp, 0, SEEK_SET);

	char *buff = malloc(fsize + 1);
	fread(buff, 1, fsize, fp);
	
	fclose(fp);

	//-------------------------------------------
	// Set up bitmap 
	//-------------------------------------------

	int optimal = nextPowerOf2(sqrt(fsize));// + 2; for the border
    int counter = 0;

    RGB_data buffer[optimal][optimal];

    memset(buffer, 0, sizeof(buffer));

    uint8_t r,g,b;
    uint8_t def = 0x11;

    //-------------------------------------------
	// Convert bytes to color squares
	//-------------------------------------------

    for (int i = 0; i < optimal; i++) {
        for (int j = 0; j < optimal; j++) {
            uint8_t mod = counter%5;

            if (mod<2) {
                buffer[i][j].r = (unsigned char)buff[counter];
                buffer[i][j].g = buffer[i][j].b = def;
            }
            else if (mod<4) {
                buffer[i][j].g = (unsigned char)buff[counter];
                buffer[i][j].r = buffer[i][j].b = def;
            }
            else {
                buffer[i][j].b = (unsigned char)buff[counter];
                buffer[i][j].r = buffer[i][j].g = def;
            }

            if (counter++>fsize) {
                counter = 0;
            }
        }
    }

    //-------------------------------------------
	// Generate it
	//-------------------------------------------

   	generateBitmap(filename, optimal, optimal, (BYTE*)buffer);  
}
