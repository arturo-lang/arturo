/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/main.c
 *****************************************************************/

#include "arturo.h"
#include "version/version.h"

/**************************************
  Helpers
 **************************************/

void showVersion() {
	struct utsname unameData;
	uname(&unameData);

    printf("\x1B[32m\x1B[1mArturo %s\x1B[0m (%s build %s) [%s-%s]\n",Version,BuildDate,BuildNo,unameData.machine,unameData.sysname);
    printf("(c) 2019-2020 Yanis Zafirópulos\n");
    printf("\n");
}

void showHelp(){
	showVersion();

	printf("\e[1;37musage:\e[00m arturo [options] <filename> [args...]\n\n");

	printf("\e[1;36mcommand\e[00m\n");
	printf("    -h           - show (this) help information\n");
	printf("    -v           - show version\n\n");
	
	printf("\e[1;36moptions\e[00m\n");
    printf("    -i PATH      - set include path\n");
    printf("    -c           - compile only\n");
    printf("    -x           - execute object file\n");
    printf("    -O           - optimize code\n");
	printf("\n");
}

/**************************************
  The Main Entry
 **************************************/

int main(int argc, char** argv) {
    // process command-line arguments
	char* includePath = NULL;
    bool compileOnly = false;
    bool executeObject = false;
    bool doOptimize = false;

	int opt; 

	while((opt = getopt(argc, argv, "hvi:cxO")) != -1) {  
        switch(opt) {  
        	case 'h':
        		showHelp();
        		exit(0);
        	case 'v':
        		showVersion();
        		exit(0);
        	case 'i':
        		includePath = optarg;
        		break;
            case 'c':
                compileOnly = true;
                break;
            case 'x':
                executeObject = true;
                break;
            case 'O':
                doOptimize = true;
                break;
        	default:
        		exit(1);
        }  
    }  

    int extraArgs = argc-optind;

    if (compileOnly && executeObject) {
        cmdlineError("cannot use -c and -x simultaneously");
    }

    if (!extraArgs) {
        if (compileOnly || executeObject) {
            cmdlineError("cannot use -c or -x without an input file");
        }
        if (doOptimize) {
            cmdlineError("extraneous argument -O found");
        }
        Env = (Environment){
            .littleEndian = IS_LITTLE_ENDIAN,
            .include = includePath
        };
    	replStart();
    }
    else {
        if (compileOnly) {
            Env = (Environment){
                .littleEndian = IS_LITTLE_ENDIAN,
                .include = includePath,
                .optimize = doOptimize
            };
            vmCompileScript(argv[optind]);
        }
        else if (executeObject) {
            Env = (Environment){
                .littleEndian = IS_LITTLE_ENDIAN,
                .include = NULL,
                .optimize = doOptimize,
                .argv = argv,
                .argi = optind
            };
            vmRunObject(argv[optind]);
        }
        else {
            Env = (Environment){
                .littleEndian = IS_LITTLE_ENDIAN,
                .include = includePath,
                .optimize = doOptimize,
                .argv = argv,
                .argi = optind
            };
            vmRunScript(argv[optind]);
        }
    }

    return 0;
}

/****************************************
   This is the end,
   my only friend, the end...
 ****************************************/