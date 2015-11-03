# The Computer Language Shootout
# http://shootout.alioth.debian.org
#
# contributed by jose fco. gonzalez
# modified by Sokolov Yura
# Adapted for the Ruby Benchmark Suite.

require "../../utils/bench"

def frecuency(seq, length)
  n, table = seq.length - length + 1, Hash(String, Int32).new(0)
  f, i = nil, nil
  (0 ... length).each do |f|
      (f ... n).step(length) do |i|
          table[seq[i,length]] += 1
      end
  end
  return n,table
end

def sort_by_freq(seq, length)
  n,table = frecuency(seq, length)
  a, b, v = nil, nil, nil
  table.map{|a,b| [a,b]}.sort{|a,b| b[1].to_s <=> a[1].to_s}.each do |v|
      puts "%s %.3f" % [v[0].to_s.upcase,((v[1].to_i*100).to_f/n)]
  end
    puts
end

def find_seq(seq, s)
  n,table = frecuency(seq, s.length)
  puts "#{table[s].to_s}\t#{s.upcase}"
end

Bench.run [1] do |n|
  seq = ""
  fname = File.dirname(__FILE__) + "/fasta.input"
  File.open(fname, "r").each_line do |line|
    seq += line.chomp
  end
  [1,2].each {|i| sort_by_freq(seq, i) }
  %w(ggt ggta ggtatt ggtattttaatt ggtattttaatttatagt).each{|s| find_seq(seq, s) }
end
