/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/repl/lrepl.c
 *****************************************************************/

#include "../arturo.h"

/**************************************
  Helpers
 **************************************/

int getch() {
   struct termios oldtc;
   struct termios newtc;
   int ch;

   tcgetattr(STDIN_FILENO, &oldtc);
   newtc = oldtc;
   newtc.c_lflag &= ~(ICANON | ECHO);
   tcsetattr(STDIN_FILENO, TCSANOW, &newtc);
   ch=getchar();
   tcsetattr(STDIN_FILENO, TCSANOW, &oldtc);
   return ch;
}

/**************************************
  Methods
 **************************************/

#define IND column-startcol-1
#define SIZE maxcol-startcol
#define LINE maxcol+startcol
#define OVERLAY() \
	for (int i=0; i<maxcol; i++) printf(" "); \
    for (int i=0; i<maxcol; i++) printf("\b");

FILE* tmp;

void replStart() {
	showVersion();

	printf("\x1B[38;5;208m# Launching interactive console; Rock on.\n");
    printf("# Type '?help' for help on console commands\x1B[0m\n");
    printf("\n");

	int ch;
    int line = 0;
    char* prompt = "\e[1m$ \e[0m";
    
    CStringArray* history = aNew(CString, 0);

    char* buff;

    while (true) {
    	int startcol = strlen(prompt);
    	int column = strlen(prompt);
    	int maxcol = column;
    	int currentItem = history->size;

    	tmp = tmpfile();

    	buff = calloc(512,sizeof(char));
    	printf(prompt,line);
    	while ((ch=getch())!='\n') {

    		if (ch==27) { // arrow key
    			getch();
    			ch=getch();

    			switch (ch) {
    				case 65: {
    					if (--currentItem>=0) {
    						for (int i=0; i<LINE; i++){
    							printf("\b");
    						}
    						printf(prompt,line);
    						OVERLAY();
    						column = strlen(prompt) + strlen(history->data[currentItem]);
    						maxcol = column;
    						printf("%s",history->data[currentItem]);
    						char cc;
    						int cnt = 0;
    						while ((cc=*history->data[currentItem]++)!='\0') {
    							buff[cnt++] = cc;
    						}
    					}
    					else {
    						++currentItem;
    						printf("\a");
    					}
    					break;
    				}
    				case 66:  {
    					if (++currentItem<history->size) {
    						for (int i=0; i<LINE; i++){
    							printf("\b");
    						}
    						printf(prompt,line);
    						OVERLAY();
    						column = strlen(prompt) + strlen(history->data[currentItem]);
    						maxcol = column;
    						printf("%s",history->data[currentItem]);
    					}
    					else {
    						--currentItem;
    						for (int i=0; i<LINE; i++){
    							printf("\b");
    						}
    						printf(prompt,line);
    						OVERLAY();
    						column = strlen(prompt);
    						maxcol = column;
    						
    					}
    					break;
    				}
    				case 67: if (++column<=maxcol) printf("%c",buff[IND]); else { printf("\a"); column--; } break;
    				case 68: if (--column>=startcol) printf("\b"); else { printf("\a"); column++; } break;
    				default: break;
    			}

    			//printf("%d",ch);
    		}
    		else if (ch==127) { // backspace
    			if (--column>=startcol) { printf("\b \b"); maxcol--; }
    			else { printf("\a"); column++; }
    		}
    		else { // other character
    			column++;
    			if (column>maxcol) maxcol = column;
    			buff[IND] = ch;
    			printf("%c",ch);	
    		}
    	}
    	buff[SIZE]='\0';
    	printf("\n");

    	//String* input = sNew(buff);
    	//printf("got: |%s|\n",input->content);

    	if (!strcmp(buff,"history")) {
    		aEach(history,i) {
    			printf("%d -> %s\n",i,history->data[i]);
    		}
    	}

    	aAdd(history,strdup(buff));

    	int i = 0;
    	while (buff[i] != '\0') { 
        	fputc(buff[i], tmp); 
        	i++; 
    	}  
    	fputc('\n',tmp);

        rewind(tmp);

    	Value result = vmRunScript(tmp);
    	print("\e[2m= ");
    	printValue(result);
    	printf("\e[0m\n\n");

    	line++;
    	free(buff);
	}


}