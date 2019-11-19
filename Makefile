# *****************************************************************
# * Arturo
# * 
# * Programming Language + Interpreter
# * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
# *
# * @file: Makefile
# *****************************************************************]#

# #================================================
# # Setup
# #================================================

# Definitions

APP     = arturo

# Environment

NIM     = nim 
NIMBLE  = nimble
FLEX    = flex
BISON   = bison
CC      = gcc
AR      = ar
MAKE    = make
CP 		= cp
RM 		= rm
MV 		= mv
YES 	= yes
DATE 	= date
GIT 	= git
AWK 	= awk

STRIP   = strip
UPX     = upx

UPX_EXISTS := $(shell command -v $(UPX) 2> /dev/null)

# Files & Paths

BIN      = bin

NIM_PATH = src
NIM_MAIN = $(NIM_PATH)/main.nim

INSTALL_DIR    	= /usr/local/bin

PARSER_L        = $(NIM_PATH)/parser/lexer.l
PARSER_L_OUT    = lex.yy.c
PARSER_L_OBJ    = lex.yy.o
PARSER_P        = $(NIM_PATH)/parser/parser.y
PARSER_P_OUT    = parser.tab.c
PARSER_P_OBJ    = parser.tab.o

PARSER          = parser.a

BUILD_NO_TXT	= $(NIM_PATH)/rsrc/build.txt
BUILD_DATE_TXT 	= $(NIM_PATH)/rsrc/build_date.txt

# Configurations

CFG_RELEASE     = -d:release \
				  -d:danger \
				  \
				  --gc:regions \
				  --threads:on \
				  --nimcache:.cache/release

CFG_MINI 		= -d:release \
				  -d:danger \
				  -d:mini \
				  \
				  --gc:regions \
				  --threads:on \
				  --nimcache:.cache/mini
EXT_MINI 		= _mini

CFG_PROFILE 	= -d:release \
				  -d:profiler \
				  --profiler:on \
				  --stackTrace:on \
				  \
				  --gc:regions \
				  --threads:off \
				  --nimcache:.cache/profile
EXT_PROFILE 	= _profile

CFG_MEMPROFILE 	= -d:release \
			  	  -d:memProfiler \
			      --profiler:off \
			      --stackTrace:on \
			      \
			      --threads:on \
			      --nimcache:.cache/memprofile
EXT_MEMPROFILE	= _memprofile

CFG_DEBUG 		= -d:release \
			  	  -d:debug \
			      --debugger:native \
			      \
			      --gc:regions \
			      --threads:on \
			      --nimcache:.cache/debug
EXT_DEBUG 		= _debug

# Flags

NIM_LANG    = c

NIM_FLAGS   = --opt:speed \
			  --hints:on \
			  --passL:parser.a \
			  --embedsrc \
			  --checks:off \
			  --overflowChecks:on \
			  --forceBuild:on

NIM_GCC_FLAGS   = --gcc.options.speed="-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math -ldl" \
				  --gcc.options.linker="-flto -ldl"

NIM_CLANG_FLAGS = --clang.options.speed="-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math -ldl" \
				  --clang.options.linker="-flto -ldl -lm"

FLEX_FLAGS          = -F -8
BISON_FLAGS         = -d 
PARSER_GCC_FLAGS    = -O4 -Ofast -flto -fno-strict-aliasing -c 
AR_FLAGS            = rvs

# #================================================
# # Tasks
# #================================================

# Main

release:
	$(MAKE) $(PARSER)
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_RELEASE) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP) $(NIM_MAIN)
ifdef UPX_EXISTS 
	$(UPX) $(BIN)/$(APP)
else
	$(STRIP) $(BIN)/$(APP) 
endif
	$(MAKE) update_build
	$(MAKE) clean

mini:
	$(MAKE) $(PARSER)
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_MINI) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_MINI) $(NIM_MAIN)
ifdef UPX_EXISTS 
	$(UPX) $(BIN)/$(APP)_mini
else
	$(STRIP) $(BIN)/$(APP)_mini 
endif
	$(MAKE) update_build
	$(MAKE) clean

profile:
	$(MAKE) $(PARSER)
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_PROFILE) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_PROFILE) $(NIM_MAIN)
	$(MAKE) clean

memprofile:
	$(MAKE) $(PARSER)
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_MEMPROFILE) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_MEMPROFILE) $(NIM_MAIN)
	$(MAKE) clean

debug:
	$(MAKE) $(PARSER)
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_DEBUG) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_DEBUG) $(NIM_MAIN)
	$(MAKE) clean

# Installer

install: $(BIN)/$(APP)
	$(CP) $(BIN)/$(APP) $(INSTALL_DIR)

# Helpers

$(PARSER): $(PARSER_L) $(PARSER_P)
	$(FLEX) $(FLEX_FLAGS) $(PARSER_L)
	$(BISON) $(BISON_FLAGS) $(PARSER_P)
	$(CC) $(PARSER_GCC_FLAGS) $(PARSER_L_OUT)
	$(CC) $(PARSER_GCC_FLAGS) $(PARSER_P_OUT)
	$(AR) $(AR_FLAGS) $(PARSER) $(PARSER_L_OBJ) $(PARSER_P_OBJ)

update_build:
	$(AWK) '/([0-9]+)/ { printf "%d", $$1+1 }' < $(BUILD_NO_TXT) > src/rsrc/build_new.txt
	$(YES) | $(RM) -rf $(BUILD_NO_TXT)
	$(MV) src/rsrc/build_new.txt $(BUILD_NO_TXT)
	$(DATE) +%d-%b-%Y > "$(BUILD_DATE_TXT)"

git_commit:
	$(GIT) add $(BUILD_NO_TXT)
	$(GIT) commit -m "updated build number"

clean:
	rm -f $(PARSER_L_OUT) $(PARSER_P_OUT) $(PARSER_L_OBJ) $(PARSER_P_OBJ) *.h
