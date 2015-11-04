require "../../utils/bench"

require "socket"

Bench.run [1, 100, 500] do |n|
  server = TCPServer.new "127.0.0.1", 0
  host, port = server.addr.ip_address.to_s, server.addr.ip_port.to_s.to_i

  n.times do
   client = TCPSocket.new host, port
   server_conn = server.accept
   client.close
   server_conn.close
  end
end
