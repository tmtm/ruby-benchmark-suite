require "../../utils/bench"

class Array
  def qsort
    return [] of Int32 if self.empty?
    pivot = self[0]
    tail = self[1..-1]
    (tail.select {|el| el < pivot }).qsort + [pivot] +
      (tail.select {|el| el >= pivot }).qsort
  end
end

Bench.run [1] do |n|
  fname = File.dirname(__FILE__) + "/random.input"
  array = File.read(fname).split(/\n/).map{|m| m.to_i{0} }
  puts "Quicksort verified." if array.qsort == array.sort
end
