ind = 0
lexer = ""
statement = ""
library = ""
File.read("src/lib/system.nim").force_encoding("utf-8").split("\n").each{|l|
    if l.include? "SystemFunction(lib:\"" and !l.include?("#SystemFunction(lib:\"")
        id = (l.scan /name:\"([^\"]+)\"/)[0][0]
        lib = (l.scan /lib:\"([^\"]+)\"/)[0][0]
        lexer += "\"#{id}\" { yylval.code = #{ind}; return SYSTEM_CMD; }\n"
        statement += "                of #{ind}: #{lib.capitalize()}_#{id.gsub("!","I")}()\n"
        library += "\t#{lib}.#{id}\n"

        ind = ind + 1
    end
}

File.open("src/parser/lexer_final.l","w"){|f|
    f.write(File.read("src/parser/lexer.l").gsub("\%\%SYSTEM_CMD\%\%",lexer))
}

# File.open("src/core/statement_final.nim","w"){|f|
#     f.write(File.read("src/core/statement.nim").gsub("\%\%SYSTEM_CMD\%\%",statement))
# }

#puts statement
puts library