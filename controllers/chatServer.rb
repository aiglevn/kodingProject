require 'thin'
require 'sinatra/base'
require 'em-websocket'

EventMachine.run do
  class AppChatServer < Sinatra::Base

  	 #set :port, 3000 
  	 set :environment, :production # can co de truy cap duoc tu may khac trong LAN
     #set :static, true

  	# sets root as the parent-directory of the current file
	set :root, File.join(File.dirname(__FILE__), '..')
	# sets the view directory correctly
	set :views, Proc.new { File.join(root, "views") } 

    get '/chat' do
      erb :chatIndex
    end
  end

  # our WebSockets server logic will go here
  @clients = []

  EM::WebSocket.start(:host => '0.0.0.0', :port => '3001') do |ws|  # 0.0.0.0 | 192.168.1.127
    ws.onopen do |handshake|
      @clients << ws
      ws.send "Connected to #{handshake.path}."
    end

    ws.onclose do
      ws.send "Closed."
      @clients.delete ws
    end

    ws.onmessage do |msg|
      puts "Received Message: #{msg}"
      @clients.each do |socket|
        socket.send msg
      end
    end
  end

  AppChatServer.run! :port => 3000
end