# Include the library:
require 'socket'

  # Create the object:
  TCPSocket.open('localhost', 11000) do |server|

    # Print what the server initially says:
   sleep(1)
   STDOUT.print server.read_nonblock(4096)

   # Loop continually:
   loop do 

      # Get input from the user:
      input = STDIN.gets

      # Send it to the server:
      server.puts input
      server.flush

      # Print the server’s response:
      STDOUT.print server.readpartial(4096).chomp

      # Terminate?
      break if input.chomp == 'quit'

   end # End of loop.

 end # End of TCPSocket block.

 # Add a newline:
 puts