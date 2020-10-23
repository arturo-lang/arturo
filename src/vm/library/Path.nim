######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: library/Path.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/env, vm/stack, vm/value

#=======================================
# Methods
#=======================================

template Module*():untyped =
	# EXAMPLE:
	# print module 'html 		; /usr/local/lib/arturo/html.art
	#
	# do.import module 'html	; (imports given module)

    require(opModule)

    stack.push(newString("/usr/local/lib/arturo/" & x.s & ".art"))

template Relative*():untyped =
	# EXAMPLE:
	# ; we are in folder: /Users/admin/Desktop
	#
	# print relative "test.txt"
	# ; /Users/admin/Desktop/test.txt
	
    require(opRelative)

    stack.push(newString(joinPath(env.currentPath(),x.s)))
