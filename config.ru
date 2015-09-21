$LOAD_PATH << '.'  #load duong dan root

require 'controllers/user-ctrl.rb'
UsersServices.run!

# require 'controllers/chatServer.rb'
# AppChatServer.run!