require 'sinatra' 
require 'json' 
require 'sinatra/base'
require 'socket'

class Testsocket1 < Sinatra::Base

	set :environment, :production

	port = 11000
	server = TCPServer.open('0.0.0.0', port) # them '192.168.1.127' de may khac telnet duoc tu LAN: telnet 192.168.1.127 11000

	# Print a message:
	STDOUT.puts "Server dang chay roi, port: #{port}. Press Control + C to terminate."

	# Run continuously:
	 loop do
		 # Each connection is a new thread:
		 Thread.new(server.accept) do |client|

		 	STDOUT.puts "One more client connected"

			  # Greet the client:
			  client.puts 'Connected!'
			  client.print 'Enter a command ("quit" to terminate): '

			  # Get the input:
			  while input = client.gets
				   # Drop the newline:
				   input.chomp!

				   # Terminate?
				   if input == 'quit'
				   		STDOUT.puts "One client Exit"
				   		break
				   end

				   # Print some messages:
				   STDOUT.puts "#{client.peeraddr[2]} :#{client.peeraddr[1]} entered: '#{input}'"
				   client.puts "You entered '#{input}'."
				   client.print 'Enter a command ("quit" to terminate): '
				   client.flush
			  end # End of while loop.

			  # Close the connection:
			  client.puts 'Terminating the connection...'
			  client.flush
			  client.close
		 end # End of Thread.new
	 end # End of loop.

end

Testsocket1.run!
=begin
while client = server.accept
	# Send the client the message:
	client.puts 'Xin chao, Socket World !'

	# Close the connection:
	client.close
end
=end