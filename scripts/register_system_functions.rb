ind = 0
lexer = ""
compiler = "{.computedGoto.}\n"
compiler += "case stm.code\n"
File.read("src/compiler.nim").force_encoding("utf-8").split("\n").each{|l|
	if l.include? "SystemFunction(lib:\"" and !l.include?("#")
		id = (l.scan /name:\"([^\"]+)\"/)[0][0]
		lib = (l.scan /lib:\"([^\"]+)\"/)[0][0]

		lexer += "\"#{id}\" { yylval.code = #{ind}; return SYSTEM_CMD; }\n"
		compiler += "    of #{ind}: #{lib.capitalize}_#{id}(stm.expressions)\n"

		ind = ind + 1
	end
}

compiler += "    else: result = NULL"

# File.open("src/system.nim","w"){|f|
# 	f.write(compiler)
# }

File.open("src/parser/lexer_final.l","w"){|f|
	f.write(File.read("src/parser/lexer.l").gsub("\%\%SYSTEM_CMD\%\%",lexer))
}