#!/usr/bin/env ruby

require 'colorize'

def execute(comp,scpt,shld)
	got = `/usr/bin/time -lp #{comp} #{scpt} 2>&1`
	time = ""
	mem = ""
	if !got.include?(shld) 
		return []
	end

	got.split("\n").each{|l|
		if l.include? "user "
			time = l.gsub("user","").strip
		elsif l.include? "maximum resident set size"
			mem = l.gsub("maximum resident set size","").strip
		end
	}
	return [time,mem]
end

Dir["benchmarks/*.art"].sort.each{|b|
	puts "==================================================================================="
	puts ('%-30s' % b.gsub("benchmarks/","").gsub(".art","").upcase()).colorize(:magenta) + "  |  " + ('%-10s' % "Time") + "   |   " + ('%-15s' % "Mem")
	puts "==================================================================================="

	should = File.read(b.gsub(".art",".out"))

	got = execute("./arturo",b,should)
	if got==[]
		puts ('%-30s' % 'Arturo') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
	else
		puts ('%-30s' % 'Arturo') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
	end

	if File.exist? (b.gsub(".art",".rb.test"))
		got = execute("ruby",b.gsub(".art",".rb.test"),should)
		if got==[]
			puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".py.test"))
		got = execute("python",b.gsub(".art",".py.test"),should)
		if got==[]
			puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".py3.test"))
		got = execute("python3",b.gsub(".art",".py3.test"),should)
		if got==[]
			puts ('%-30s' % 'Python3') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Python3') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".php.test"))
		got = execute("php",b.gsub(".art",".php.test"),should)
		if got==[]
			puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".pl.test"))
		got = execute("perl",b.gsub(".art",".pl.test"),should)
		if got==[]
			puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".lua.test"))
		got = execute("luac",b.gsub(".art",".lua.test"),should)
		if got==[]
			puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".tcl.test"))
		got = execute("tclsh",b.gsub(".art",".tcl.test"),should)
		if got==[]
			puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-15s' % got[1])
		end
	else
		puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end

	puts "\n"
}