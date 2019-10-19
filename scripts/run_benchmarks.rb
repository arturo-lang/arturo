require 'benchmark'

def processOne(path,title,expect)
	puts path
	if File.exist? (path)
		got = ""
		time = Benchmark.measure do
  			got = `#{title} #{path}`.strip
		end
		if got != expect
			puts "#{title}: X"
		else
			puts "#{title}: #{time}"
		end
	else
		puts "#{title}: -"
	end
end

Dir.entries("../benchmarks").each{|f|
	if f.include? (".art")
		puts "=============="
		puts f
		puts "=============="
		artpath = Dir.pwd + "/../benchmarks/"+  f
		rbpath = Dir.pwd + "/../benchmarks/"+  f.gsub(".art",".rb.test")
		pypath = Dir.pwd + "/../benchmarks/"+  f.gsub(".art",".py.test")
		phppath = Dir.pwd + "/../benchmarks/"+  f.gsub(".art",".php.test")
		luapath = Dir.pwd + "/../benchmarks/"+  f.gsub(".art",".lua.test")
		tclpath = Dir.pwd + "/../benchmarks/"+  f.gsub(".art",".tcl.test")

		expect = File.read(Dir.pwd + "/../benchmarks/"+  f.gsub(".art",".out")).strip

		processOne(artpath,"../arturo",expect)
		processOne(rbpath,"ruby",expect)
		processOne(pypath,"python",expect)
		processOne(phppath,"php",expect)
		processOne(luapath,"lua",expect)
		processOne(tclpath,"tclsh",expect)

	end
}
