require "socket"

def parse_request(request_line)
  method, path_query, _ = request_line.split(" ")
  path, query = path_query.split("?")
  params = {}
  (query || "").split("&").each do |item|
    param_value = item.split("=")
    params[param_value[0]] = param_value[1]
  end

  [method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  http_method, path, params = parse_request(request_line)

  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"

  number = params["number"].to_i
  client.puts "<p>The current number is #{number}.</p>"

  client.puts "<a href='?number=#{number + 1}'>Increase?</a>"
  client.puts
  client.puts "<a href='?number=#{number - 1}'>Decrease?</a>"

  client.puts "</body>"
  client.puts "</html>"
  client.close
end
