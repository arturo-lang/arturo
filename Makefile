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
#/Users/drkameleon/Documents/Code/OpenSource/3rd-party/Nim/bin/
NIM     = nim
NIMBLE  = nimble
FLEX    = flex
BISON   = bison
CC      = gcc
AR      = ar
MAKE    = make
CP      = cp
RM      = rm
MV      = mv
YES     = yes
DATE    = date
GIT     = git
AWK     = awk
RUBY    = ruby

STRIP   = strip
UPX     = upx

UPX_EXISTS := $(shell command -v $(UPX) 2> /dev/null)

# Files & Paths

BIN      = bin

NIM_PATH = src
NIM_MAIN = $(NIM_PATH)/main.nim

CACHE           = .cache

INSTALL_DIR     = /usr/local/bin

PARSER_L        = $(NIM_PATH)/parser/lexer_final.l
PARSER_L_OUT    = lex.yy.c
PARSER_L_OBJ    = lex.yy.o
PARSER_P        = $(NIM_PATH)/parser/parser.y
PARSER_P_OUT    = parser.tab.c
PARSER_P_OBJ    = parser.tab.o

PARSER          = parser.a

BUILD_NO_TXT    = $(NIM_PATH)/rsrc/build.txt
BUILD_NO_TMP    = $(NIM_PATH)/rsrc/build.new.txt
BUILD_DATE_TXT  = $(NIM_PATH)/rsrc/build_date.txt

BUILD_LIBRARY_SCRIPT    = build_library.rb

# Configurations

# 				  --gc:refc \
# 				  --define:useRealtimeGC \
# 				  --tlsEmulation:off \

# 				  --define:useRealtimeGC \
# 				  --tlsEmulation:off \

CFG_RELEASE     = -d:release \
				  -d:danger \
				  \
				  --gc:refc \
				  --d:useRealtimeGC \
				  --threads:on \
				  --nimcache:$(CACHE)/release

CFG_MINI        = -d:release \
				  -d:danger \
				  -d:mini \
				  \
				  --gc:refc \
				  --d:useRealtimeGC \
				  --threads:on \
				  --nimcache:$(CACHE)/mini
EXT_MINI        = _mini

CFG_PROFILE     = -d:release \
				  -d:profiler \
				  --profiler:on \
				  --stackTrace:on \
				  \
				  --gc:regions \
				  --threads:off \
				  --nimcache:$(CACHE)/profile
EXT_PROFILE     = _profile

CFG_MEMPROFILE  = -d:release \
				  -d:memProfiler \
				  --profiler:off \
				  --stackTrace:on \
				  \
				  --threads:on \
				  --nimcache:$(CACHE)/memprofile
EXT_MEMPROFILE  = _memprofile

CFG_DEBUG       = -d:debug \
				  -d:useSysAssert \
				  -d:useGcAssert \
				  --debugger:native \
				  --stackTrace:on \
				  --d:useRealtimeGC \
				  \
				  --gc:refc \
				  --threads:on \
				  --nimcache:$(CACHE)/debug
EXT_DEBUG       = _debug

# Flags

NIM_LANG    = c

#             --hint[Conf]:off \
#             --hint[Processing]:off \
#             --hint[XDeclaredButNotUsed]:off \

NIM_FLAGS   = --opt:speed \
			  --hints:on \
			  --passL:parser.a \
			  --embedsrc \
			  --checks:off \
			  --overflowChecks:on \
			  --forceBuild:on \
			  --warnings:on

NIM_GCC_FLAGS   = --gcc.options.speed="-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math -ldl" \
				  --gcc.options.linker="-flto -ldl"

NIM_CLANG_FLAGS = --clang.options.speed="-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math -ldl" \
				  --clang.options.linker="-flto -ldl -lm"

FLEX_FLAGS          = -F -8
BISON_FLAGS         = -d 
PARSER_GCC_FLAGS    = -O4 -Ofast -flto -fno-strict-aliasing -c 
AR_FLAGS            = rvs
UPX_FLAGS           = -q

BUILD_PRINT = \e[1;34mBuilding $<\e[0m

# #================================================
# # Tasks
# #================================================

# Main

release:
	@printf "\033[1;0m*************************************************\033[0m\n"
	@printf "\033[1;0m* \033[1;32mArturo\033[0m\n"
	@printf "\033[1;0m* \033[1;32mProgramming Language\033[0m\n"
	@printf "\033[1;0m* \033[0m\n"
	@printf "\033[1;0m* (c) 2019 Yanis Zafirópulos\033[0m\n"
	@printf "\033[1;0m*************************************************\033[0m\n"
	@$(MAKE) build_library
	@$(MAKE) $(PARSER)
	@$(RM) -rf $(CACHE)/release/*
	@printf "\n\033[1;35m> Compiling main...\033[0m\n\n"
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_RELEASE) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP) $(NIM_MAIN)
	@printf "\n\033[1;35m> Compressing...\033[0m\n\n"
ifdef UPX_EXISTS 
	$(UPX) $(UPX_FLAGS) $(BIN)/$(APP) > /dev/null 2>&1
else
	$(STRIP) $(BIN)/$(APP) 
endif
	@$(MAKE) update_build
	@$(MAKE) clean
	@printf "\n\n"
	@printf "\033[1;0m*************************************************\033[0m\n"
	@printf "\033[1;0m*\033[0m \033[1;32mAll set! :)\033[0m\n"
	@printf "\033[1;0m\n"
	@printf "\033[1;0m*\033[0m You may access the binary via bin/arturo OR\n"
	@printf "\033[1;0m*\033[0m install it globally using 'make install'.\n"
	@printf "\033[1;0m*************************************************\033[0m\n\n"

mini:
	@$(MAKE) build_library
	@$(MAKE) $(PARSER)
	@$(RM) -rf $(CACHE)/mini/*
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_MINI) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_MINI) $(NIM_MAIN)
ifdef UPX_EXISTS 
	$(UPX) $(UPX_FLAGS) $(BIN)/$(APP)_mini > /dev/null 2>&1
else
	$(STRIP) $(BIN)/$(APP)_mini 
endif
	@$(MAKE) update_build
	@$(MAKE) clean

profile:
	@$(MAKE) build_library
	@$(MAKE) $(PARSER)
	@$(RM) -rf $(CACHE)/profile/*
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_PROFILE) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_PROFILE) $(NIM_MAIN)
	@$(MAKE) clean

memprofile:
	@$(MAKE) build_library
	@$(MAKE) $(PARSER)
	@$(RM) -rf $(CACHE)/memprofile/*
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_MEMPROFILE) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_MEMPROFILE) $(NIM_MAIN)
	@$(MAKE) clean

debug:
	@$(MAKE) build_library
	@$(MAKE) $(PARSER)
	@$(RM) -rf $(CACHE)/debug/*
	$(NIM) $(NIM_LANG) $(NIM_GCC_FLAGS) $(NIM_CLANG_FLAGS) $(CFG_DEBUG) $(NIM_FLAGS) --path:$(NIM_PATH) -o:$(BIN)/$(APP)$(EXT_DEBUG) $(NIM_MAIN)
	@$(MAKE) clean

# Installer

install: $(BIN)/$(APP)
	$(CP) $(BIN)/$(APP) $(INSTALL_DIR)

# Sub-tasks

build_library:
	@printf "\n\033[1;35m> Building system library...\033[0m\n\n"
	$(RUBY) $(BUILD_LIBRARY_SCRIPT)

$(PARSER): $(PARSER_L) $(PARSER_P)
	@printf "\n\033[1;35m> Compiling parser...\033[0m\n\n"
	$(FLEX) $(FLEX_FLAGS) $(PARSER_L)
	$(BISON) $(BISON_FLAGS) $(PARSER_P)
	$(CC) $(PARSER_GCC_FLAGS) $(PARSER_L_OUT)
	$(CC) $(PARSER_GCC_FLAGS) $(PARSER_P_OUT)
	$(AR) $(AR_FLAGS) $(PARSER) $(PARSER_L_OBJ) $(PARSER_P_OBJ) > /dev/null 2>&1

update_build:
	@printf "\n\033[1;35m> Updating build...\033[0m\n\n"
	$(AWK) '/([0-9]+)/ { printf "%d", $$1+1 }' < $(BUILD_NO_TXT) > $(BUILD_NO_TMP)
	$(YES) | $(RM) -rf $(BUILD_NO_TXT)
	$(MV) $(BUILD_NO_TMP) $(BUILD_NO_TXT)
	$(DATE) +%d-%b-%Y > "$(BUILD_DATE_TXT)"

git_commit:
	$(GIT) add $(BUILD_NO_TXT)
	$(GIT) commit -m "updated build number"

clean:
	@printf "\n\033[1;35m> Cleaning up...\033[0m\n\n"
	$(RM) -f *.a *.o *.c $(PARSER_L_OUT) $(PARSER_P_OUT) $(PARSER_L_OBJ) $(PARSER_P_OBJ) $(PARSER) $(PARSER_L) *.h
	$(RM) -f "bin/arturo "*
	$(RM) -f "src/rsrc/build "*
	$(RM) -f "src/parser/lexer_final "*
	$(RM) -f "src/core/statement_final"*
