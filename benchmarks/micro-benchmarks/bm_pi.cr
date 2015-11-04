#!/usr/local/bin/ruby
# from ruby_trunk/sample/pi.rb



require "../../utils/bench"
require "big_int"

Bench.run [1000, 10000] do |n|
  k, a, b, a1, b1 = BigInt.new(2), BigInt.new(4), BigInt.new(1), BigInt.new(12), BigInt.new(4)
  n.times do
    # Next approximation
    p, q, k = k*k, 2*k+1, k+1
    a, b, a1, b1 = a1, b1, p*a+q*a1, p*b+q*b1
    # Print common digits
    d = a / b
    d1 = a1 / b1
    while d == d1
      print d
      STDOUT.flush
      a, a1 = 10*(a%b), 10*(a1%b1)
      d, d1 = a/b, a1/b1
    end
  end
end
