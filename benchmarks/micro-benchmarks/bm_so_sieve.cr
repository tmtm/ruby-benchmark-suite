# from http://www.bagley.org/~doug/shootout/bench/sieve/sieve.ruby

require "../../utils/bench"

Bench.run [4000] do |num|
  count = i = j = 0
  flags0 = Array(Bool).new(8192,true)
  k = 0
  while k < num
    k+=1
    count = 0
    flags = flags0.dup
    i = 2
    while i<8192
      if flags[i]
        # remove all multiples of prime: i
        j = i+i
        while j < 8192
          flags[j] = false
          j += i
        end
        count += 1
      end
      i+=1
    end
  end
  puts count
end
