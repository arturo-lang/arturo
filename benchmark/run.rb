#!/usr/bin/env ruby

require 'colorize'

def execute(comp,scpt,shld)
	got = `/usr/bin/time -lp #{comp} #{scpt} 2>&1`
	time = ""
	mem = ""
	real = ""

	if !got.strip.include?(shld.strip) 
		return []
	end

	got.split("\n").each{|l|
		if l.include? "user "
			time = l.gsub("user","").strip
		elsif l.include? "real "
			real = l.gsub("real","").strip
		elsif l.include? "maximum resident set size"
			mem = l.gsub("maximum resident set size","").strip
		end
	}
	return [time,mem,real]
end

Dir["#{__dir__}/tests/*.art"].sort.each{|b|
	puts "====================================================================================================="
	puts ('%-30s' % b.gsub("#{__dir__}/tests/","").gsub(".art","").upcase()).colorize(:magenta) + "  |  " + ('%-10s' % "User") + "   |   " + ('%-10s' % "Real") + "   |   "+ ('%-15s' % "Mem")
	puts "====================================================================================================="

	should = File.read(b.gsub(".art",".out"))

	got = execute("bin/arturo",b,should)
	if got==[]
		puts ('%-30s' % 'Arturo') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
	else
		puts ('%-30s' % 'Arturo') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
	end

	if File.exist? (b.gsub(".art",".rb.test"))
		got = execute("ruby",b.gsub(".art",".rb.test"),should)
		if got==[]
			puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".py.test"))
		got = execute("python",b.gsub(".art",".py.test"),should)
		if got==[]
			puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".py3.test"))
		got = execute("python3",b.gsub(".art",".py3.test"),should)
		if got==[]
			puts ('%-30s' % 'Python3') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Python3') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".php.test"))
		got = execute("php",b.gsub(".art",".php.test"),should)
		if got==[]
			puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".pl.test"))
		got = execute("perl",b.gsub(".art",".pl.test"),should)
		if got==[]
			puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".lua.test"))
		got = execute("lua",b.gsub(".art",".lua.test"),should)
		if got==[]
			puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".lisp.test"))
		got = execute("clisp",b.gsub(".art",".lisp.test"),should)
		if got==[]
			puts ('%-30s' % 'Lisp') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Lisp') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Lisp') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".reb.test"))
		got = execute("rebol -q -w -s",b.gsub(".art",".reb.test"),should)
		if got==[]
			puts ('%-30s' % 'Rebol') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Rebol') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Rebol') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".tcl.test"))
		got = execute("tclsh",b.gsub(".art",".tcl.test"),should)
		if got==[]
			puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end

	puts "\n"
}