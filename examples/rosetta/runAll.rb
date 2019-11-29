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
		return false
	else
		return true
	end
end

success = 0
total = 0

Dir["#{__dir__}/*.art"].sort.each{|b|
	if File.exist?(b.gsub(".art",".out")) and !b.start_with? ("_")
		total += 1
		printf ('%-50s' % ("- " + b.gsub("#{__dir__}/","")))
		should = File.read(b.gsub(".art",".out"))
		got = execute("bin/arturo",b,should)
		if got
			success += 1
			puts ('%-10s' % "OK").colorize(:green)
		else
			puts ('%-10s' % "X").colorize(:red)
		end
	end
}

puts "\n: #{success} out of #{total} tests successful."