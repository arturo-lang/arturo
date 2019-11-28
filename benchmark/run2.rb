#!/usr/bin/env ruby

require 'awesome_print'
require 'colorize'
require 'iconv' unless String.method_defined?(:encode)

def execute(comp,scpt,shld)
	got = `/usr/bin/time -lp #{comp} #{scpt} 2>&1`
	time = ""
	mem = ""
	real = ""

	if !got.encode!('UTF-8', 'UTF-8', :invalid => :replace).force_encoding("UTF-8").strip.encode('UTF-8', 'UTF-8', :invalid => :replace).include?(shld.strip) 
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
	hashes = {}
	puts "====================================================================================================="
	puts ('%-30s' % b.gsub("#{__dir__}/tests/","").gsub(".art","").upcase()).colorize(:magenta) + "  |  " + ('%-10s' % "User") + "   |   " + ('%-10s' % "Real") + "   |   "+ ('%-15s' % "Mem")
	puts "====================================================================================================="

	should = File.read(b.gsub(".art",".out"))

	got = execute("bin/arturo",b,should)
	if got==[]
		hashes["Arturo"] = []
		#puts ('%-30s' % 'Arturo') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
	else
		hashes["Arturo"] = [got[0],got[2],got[1]]
		#puts ('%-30s' % 'Arturo') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
	end

	if File.exist? (b.gsub(".art",".rb.test"))
		got = execute("ruby",b.gsub(".art",".rb.test"),should)
		if got==[]
			hashes["Ruby"] = []
			#puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Ruby"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Ruby"] = {}
		#puts ('%-30s' % 'Ruby') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".py.test"))
		got = execute("python",b.gsub(".art",".py.test"),should)
		if got==[]
			hashes["Python"] = []#[got[0],got[2],got[1]]
			#puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Python"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Python"] = {}#[got[0],got[2],got[1]]
		#puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".py3.test"))
		got = execute("python3",b.gsub(".art",".py3.test"),should)
		if got==[]
			hashes["Python3"] = []
			#puts ('%-30s' % 'Python3') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Python3"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Python3') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Python3"] = {}
		#puts ('%-30s' % 'Python') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".php.test"))
		got = execute("php",b.gsub(".art",".php.test"),should)
		if got==[]
			hashes["PHP"] = []
			#puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["PHP"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["PHP"] = {}
		#puts ('%-30s' % 'PHP') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".pl.test"))
		got = execute("perl",b.gsub(".art",".pl.test"),should)
		if got==[]
			hashes["Perl"] = []#[got[0],got[2],got[1]]
			#puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Perl"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Perl"] = {}#[got[0],got[2],got[1]]
		#puts ('%-30s' % 'Perl') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".lua.test"))
		got = execute("lua",b.gsub(".art",".lua.test"),should)
		if got==[]
			hashes["Lua"] = []#[got[0],got[2],got[1]]
			#puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Lua"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Lua"] = {}#[got[0],got[2],got[1]]
		#puts ('%-30s' % 'Lua') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".lisp.test"))
		got = execute("clisp",b.gsub(".art",".lisp.test"),should)
		if got==[]
			hashes["Lisp"] = []#[got[0],got[2],got[1]]
			#puts ('%-30s' % 'Lisp') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Lisp"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Lisp') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Lisp"] = {}#[got[0],got[2],got[1]]
		#puts ('%-30s' % 'Lisp') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".reb.test"))
		got = execute("rebol -q -w -s",b.gsub(".art",".reb.test"),should)
		if got==[]
			hashes["Rebol"] = []#[got[0],got[2],got[1]]
			#puts ('%-30s' % 'Rebol') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Rebol"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Rebol') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Rebol"] = {}#[got[0],got[2],got[1]]
		#puts ('%-30s' % 'Rebol') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end
	if File.exist? (b.gsub(".art",".tcl.test"))
		got = execute("tclsh",b.gsub(".art",".tcl.test"),should)
		if got==[]
			hashes["Tcl"] = []#[got[0],got[2],got[1]]
			#puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
		else
			hashes["Tcl"] = [got[0],got[2],got[1]]
			#puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % got[0]) + "   |   " + ('%-10s' % got[2]) + "   |   " + ('%-15s' % got[1])
		end
	else
		hashes["Tcl"] = {}#[got[0],got[2],got[1]]
		#puts ('%-30s' % 'Tcl') + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
	end

	hashes = hashes.sort_by { |key, val| 
		if val.kind_of?(Array) 
			if val.length==0
				9999999
			else
				(val[1].to_f) 
			end
		else 
			9999999
		end }.to_h

	hashes.each{|k,v|
		if v.kind_of? (Hash)
			puts ('%-30s' % k) + "  |  " + ('%-10s' % "-") + "   |   " + ('%-10s' % "-") + "   |   " + ('%-15s' % "-")
		else
			if v.length==0
				puts ('%-30s' % k) + "  |  " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-10s' % "X").colorize(:red) + "   |   " + ('%-15s' % "X").colorize(:red)
			else
				if k=="Arturo"
					puts (('%-30s' % k) + "  |  " + ('%-10s' % v[0]) + "   |   " + ('%-10s' % v[1]) + "   |   " + ('%-15s' % v[2])).colorize(:green)
				else
					puts (('%-30s' % k) + "  |  " + ('%-10s' % v[0]) + "   |   " + ('%-10s' % v[1]) + "   |   " + ('%-15s' % v[2]))
				end
			end
		end
	}
	#ap hashes

	puts "\n"
}