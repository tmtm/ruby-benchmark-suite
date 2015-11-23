require "../../utils/bench"

a = "a"*1000
fname = File.dirname(__FILE__) + "/temp.output"
Bench.run [100] do |n|
  n.times do
    count = 0

    File.open(fname, "w") do |file|
      1000.times {
       file.print a
      }
    end
  end
end

File.delete fname
