require "../../utils/bench"

BAILOUT = 16
MAX_ITERATIONS = 1000

class Mandelbrot

	def initialize
		puts "Rendering"
		(-39...39).each do |y|
			puts
			(-39...39).each do |x|
				i = iterate(x/40.0,y/40.0)
				if (i == 0)
					print "*"
				else
					print " "
				end
			end
		end
	end

	def iterate(x,y)
		cr = y-0.5
		ci = x
		zi = 0.0
		zr = 0.0
		i = 0

		while(1)
			i += 1
			temp = zr * zi
			zr2 = zr * zr
			zi2 = zi * zi
			zr = zr2 - zi2 + cr
			zi = temp + temp + ci
			return i if (zi2 + zr2 > BAILOUT)
			return 0 if (i > MAX_ITERATIONS)
		end
	end

end

Bench.run [5] do |n|
  Mandelbrot.new
end
