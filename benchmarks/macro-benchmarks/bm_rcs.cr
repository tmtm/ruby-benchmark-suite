# random dot steraogram
# usage: rcs.rb rcs.dat
# from ruby_trunk/sample/rcs.rb

require "../../utils/bench"

def go

sw = 40.0	# width of original pattern
dw = 78.0	# width of generating Random Character Streogram
hdw = dw / 2.0
w = 20.0	# distance between eyes
h =1.0		# distance from screen and base plane
d = 0.2		# z value unit
ss="abcdefghijklmnopqrstuvwxyz0123456789#!$%^&*()-=\\[];'`,./"
#rnd = srand()	# You don't actually need this in ruby - srand() is called
# on the first call of rand().

  File.open("rcs.dat", "r").each_line do |line|
    xr = -hdw; y = h * 1.0; maxxl = -999
    s = ""
    while xr < hdw
      x = xr * (1 + y) - y * w / 2
      i = (x / (1 + h) + sw / 2)
      if (1 < i && i < line.length)
        c = line[i.to_i, 1].to_i rescue 0
      else
        c = 0
      end
      y = h - d * c
      xl = xr - w * y / (1 + y)
      if xl < -hdw || xl >= hdw || xl <= maxxl
        tt = rand(ss.length)
        c = ss[tt, 1]
      else
        c = s[(xl + hdw).to_i, 1]
        maxxl = xl
      end
      s += c
      xr += 1
    end
    #print(s, "\n")
  end

end

Bench.run [100] do |n|
  n.times { go }
end
