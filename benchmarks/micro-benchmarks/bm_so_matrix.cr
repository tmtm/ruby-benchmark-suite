# $Id: matrix-ruby.code,v 1.4 2004/11/13 07:42:14 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

require "../../utils/bench"

def mkmatrix(rows, cols)
    count = 1
    mx = Array(Array(Int32)).new
    (0 .. (rows - 1)).each do |bi|
        row = Array(Int32).new(cols, 0)
        (0 .. (cols - 1)).each do |j|
            row[j] = count
            count += 1
        end
        mx.push row
    end
    mx
end

def mmult(rows, cols, m1, m2)
    m3 = Array(Array(Int32)).new
    (0 .. (rows - 1)).each do |bi|
        row = Array(Int32).new(cols, 0)
        (0 .. (cols - 1)).each do |j|
            val = 0
            (0 .. (cols - 1)).each do |k|
                val += m1.at(bi).at(k) * m2.at(k).at(j)
            end
            row[j] = val
        end
        m3.push row
    end
    m3
end

size = 30

Bench.run [60] do |n|
  m1 = mkmatrix(size, size)
  m2 = mkmatrix(size, size)
  mm :: Array(Array(Int32))
  n.times do
      mm = mmult(size, size, m1, m2)
  end

  puts "#{mm[0][0]} #{mm[2][3]} #{mm[3][2]} #{mm[4][4]}"
end
