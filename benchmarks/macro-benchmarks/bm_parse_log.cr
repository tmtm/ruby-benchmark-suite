require "../../utils/bench"

def go filename
  # assume ARGV[0] is a log
  start_time = nil
  float = /[\d]+\.[\d]+/
  start_regex = /(#{float}).*starting up logger/
  end_regex = /(#{float}).*DONE WITH WHOLE FILE/

  starty = nil
  endy = nil
  File.read(filename).each_line {|line|
    if !starty && line =~ start_regex
      puts line if $VERBOSE
      starty = $1.to_f
    else
      begin
       if line =~ end_regex # pesky encoding errors
        puts line if $VERBOSE
        endy = $1.to_f
        break # break out of enumerator early
       end
      rescue e # encoding error...
               puts line, line.inspect
               sleep 5
      end
    end
  } unless File.directory? filename
  if endy && starty
    puts endy - starty
    endy - starty
  else
          nil
  end

end

Bench.run [100] do |n|
  n.times { go "peer_log.txt" }
end
