#!/usr/bin/env ruby

require 'awesome_print'

lines = File.read("trace.log").split("\n")
output = []
docount = false
lines.each{|line|
	if line.include? "Calls" and line.include? "Time" and line.include? "Call"
		docount = true
	end

	if docount
		if line.strip!=""
			output << line.split(/\s{4,}/).select{|a| a.strip!=""}.join(",")
		end
	end

}

File.open("trace.csv","w"){|f|
	output.each{|o|
		f.write(o + "\n")
	}
}
