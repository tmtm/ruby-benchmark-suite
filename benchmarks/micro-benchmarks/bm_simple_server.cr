require "../../utils/bench"
require "socket"

Bench.run [1, 100, 100000] do |n|
  server = TCPServer.new "127.0.0.1", 0
  client = TCPSocket.new server.addr.ip_address.to_s, server.addr.ip_port.to_s.to_i
  server_conn = server.accept
  n.times do
    client.print "a"
    server_conn.read_nonblock 1024 # "a"
  end
end
