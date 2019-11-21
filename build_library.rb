ind = 0
lexer = ""
File.read("src/lib/system.nim").force_encoding("utf-8").split("\n").each{|l|
	if l.include? "SystemFunction(lib:\""# and !l.include?("#")
		id = (l.scan /name:\"([^\"]+)\"/)[0][0]
		lexer += "\"#{id}\" { yylval.code = #{ind}; return SYSTEM_CMD; }\n"
		ind = ind + 1
	end
}

File.open("src/parser/lexer_final.l","w"){|f|
	f.write(File.read("src/parser/lexer.l").gsub("\%\%SYSTEM_CMD\%\%",lexer))
}