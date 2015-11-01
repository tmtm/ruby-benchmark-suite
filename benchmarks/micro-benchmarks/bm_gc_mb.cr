require "../../utils/bench"

Bench.run [500_000, 1_000_000, 3_000_000] do |n|
  a = [] of Array(Nil)
  n.times { a << [] of Nil} # use up some RAM
  n.times {[] of Nil}
end
