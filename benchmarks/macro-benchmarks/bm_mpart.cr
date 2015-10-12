#! ./ruby
# split file into multiple parts
# from ruby_trunk/sample/mpart.rb

require "../../utils/bench"

def go

lines = 3 # cut it at line 3

basename = "file_to_split.txt"
extname = "part"

part = 1
line = 0

fline = 0
ifp = File.open(basename)
ifp.each_line do |i|
  fline = fline + 1
end
ifp.close

parts = fline / lines + 1

ofp :: File

ifp = File.open(basename)
ifp.each_line do |i|
  if line == 0
    ofp = File.open(sprintf("%s.%s%02d", basename, extname, part), "w")
    ofp.printf("%s part%02d/%02d\n", basename, part, parts)
    ofp.print("BEGIN--cut here--cut here\n")
  end
  ofp.print(i)
  line = line + 1
  if line >= lines
    ofp.print("END--cut here--cut here\n")
    ofp.close
    part = part + 1
    line = 0
  end
end
ofp.print("END--cut here--cut here\n")
ofp.close

ifp.close

end

Bench.run [300] do |n|
  n.times { go }
end

Dir["file_to_split.txt.*"].each do |file| File.delete file; end
