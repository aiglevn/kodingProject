# Ruby Uno Client 

require 'json' 
require 'rest-client' 

class UnoClient 
  #attr_reader :name 

  def initialize name 
    @name = name 
  end 

  def join_game 
    response = RestClient.post 'http://localhost:8080/join', :data => {name: @name}.to_json, :accept => :json          
    puts JSON.parse(response,:symbolize_names => true)

    rescue => e
      puts "ERROR: #{e}"
  end 

  def get_cards 
    response = RestClient.get 'http://localhost:8080/cards', {:params => {:name => @name}} 
    puts response 
  end 

  def deal 
    response = RestClient.post 'http://localhost:8080/deal', :data =>{}.to_json, :accept => :json 
    puts response 
  end 

  def edit_name
    response = RestClient.put 'http://localhost:8080/editname', {:params => {:oldname => @oldname, :newname => @newname}}, :accept => :json     
    puts JSON.parse(response,:symbolize_names => true) 
  end 

  def remove_user
    response = RestClient.delete 'http://localhost:8080/removeuser', {:params => {:name => @name}}, :accept => :json     
    puts JSON.parse(response,:symbolize_names => true) 
  end 

end

=begin
  Trong Interactive ruby :
  load "C:/_Data/Projects/RubyTraining/api/uno-client.rb" # nen dung load() de sau khi thay doi file code, co the load lai duoc ma ko phai dong cua so di mo lai
  require "C:/_Data/Projects/RubyTraining/api/uno-client.rb"
  Dir.pwd
  Dir.chdir("C:/_Data/Projects/RubyTraining")
  Dir.pwd
  require "./api/uno-client.rb"
  user1_uno = UnoClient.new 'Dung'
  user1_uno.join_game

  UnoClient.new('Nam').join_game
  UnoClient.new('Minh').join_game
  UnoClient.new('Ngoc').join_game
  UnoClient.new('Tuan Anh').join_game

  user1_uno.deal

  user1_uno.get_cards
  user1_uno.get_cards
  UnoClient.new('Nam').get_cards
=end