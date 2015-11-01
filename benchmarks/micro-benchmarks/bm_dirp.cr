# directory access
# list all files but .*/*~/*.o

require "../../utils/bench"

Bench.run [10000] do |n|
  n.times do
    dirp = Dir.open(".")
    dirp.each do |f|
      case f
      when /^\./, /~$/, /\.o/
        # do not print
      else
        # don't print since we don't care about print speed
        #print f, "\n"
      end
    end
    dirp.close
  end
end
