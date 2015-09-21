# Ruby Uno Server
require 'sinatra' 
require 'json' 
require 'sinatra/base'
require 'erb'

require "rubygems"
require "sequel"

#==================================

class UnoServer 
  attr_reader :deck, :pool, :hands, :number_of_hands 
  MAX_HANDS = 4 
  def initialize 
    @hands = Array.new 
    @number_of_hands = 0 
    @pool = Array.new 
    @deck = %w(2-diamond 3-diamond 4-diamond 5-diamond 6-diamond 7-diamond 8-diamond 9-diamond 10-diamond) 
    @deck.concat %w(2-heart 3-heart 4-heart 5-heart 6-heart 7-heart 8-heart 9-heart 10-heart) 
    @deck.concat %w(2-club 3-club 4-club 5-club 6-club 7-club 8-club 9-club 10-club) 
    @deck.concat %w(2-spade 3-spade 4-spade 5-spade 6-spade 7-spade 8-spade 9-spade 10-spade) 
    @deck.concat %w(jack-diamond jack-heart jack-club jack-spade) 
    @deck.concat %w(queen-diamond queen-heart queen-club queen-spade) 
    @deck.concat %w(king-diamond king-heart king-club king-spade) 
    @deck.concat %w(ace-diamond ace-heart ace-club ace-spade) 
    @deck.concat %w(joker joker) 
  end 

  def get_all_from_db
    ds_users = Array.new
    db_mysql = Sequel.connect(:adapter=>'mysql2', :host=>'localhost', :database=>'whichs', :user=>'quantv', :password=>'xUqYEcsofvvB', :encoding=>'utf8')  #=> OK

    puts "* Using Sequel - gem mysql2"
    ds_users = db_mysql.fetch("SELECT * FROM users where id in (1, 2, 5)")
    #ds_users.each{|r| puts r} 
    return ds_users 
  end 

  def join_game player_name 
    return false unless @hands.size < MAX_HANDS 
    player = { 
        name: player_name, 
        cards: [] 
    } 
    @hands.push player 
    true 
  end 

  def deal 
    return false unless @hands.size > 0 
    @pool = @deck.shuffle 
    @hands.each {|player| player[:cards] = @pool.pop(5)} 
    true 
  end 

  def count_user
    puts "tong so user:" + @hands.count.to_s
    @hands.count
  end

  def get_cards player_name 
    cards = 0 
    @hands.each do |player| 
      if player[:name] == player_name 
        cards = player[:cards].dup 
        break 
      end 
    end 
    cards 
  end 

  def edit_name(oldname, newname)
    puts "need to edit name player: " + oldname.to_s

    if(@hands.index{|player| player[:name] == oldname} == nil)
      puts "Ko tim thay user: " + oldname.to_s
      return false
    else
      puts "Tim thay user: " + oldname.to_s
      @hands.select {|player| player[:name] == oldname}.each do |user| 
        user[:name] = newname
      end 
    end 

    true 
  end

  def remove_user player_name  
    puts "need to remove player: " + player_name.to_s

    if(@hands.index{|player| player[:name] == player_name} == nil)
      puts "Ko tim thay user: " + player_name.to_s
      return false
    else
      puts "Tim thay user: " + player_name.to_s
      @hands.delete_if {|player| player[:name] == player_name}
    end  
   
    true 
  end

end

#==========================================================

###### Sinatra Part ###### 
class UnoServer_Sinatra < Sinatra::Base # 

  uno = UnoServer.new 
  
  set :port, 8080 
  set :environment, :production 
  
#===============================
  get '/get_all_from_db' do 
    content_type :json, :charset => 'utf-8'
    return_message = {} 
    arrUsers = uno.get_all_from_db()

    strUsers = '[' 
    #arrUsers.each{|r| strUsers += (r.to_json + ',')} 
    dem = 0
    arrUsers.each do |row|
      strUsers += (row.to_json)
      dem += 1
      if(arrUsers.count > dem)
        strUsers += ','
      end
    end
    strUsers += ']'

    return_message[:users] = JSON.parse(strUsers)
    return_message.to_json 
  end 
#===============================
  get '/count' do 
    return_message = {} 
    total_user = uno.count_user() 
    return_message[:status] = 'Tong so user la: ' + total_user.to_s
    return_message.to_json 
  end 
#===============================
  get '/cards' do 
    return_message = {} 
    if params.has_key?('name') 
      cards = uno.get_cards(params['name']) 
      if cards.class == Array 
        return_message[:status] == 'success ok' 
        return_message[:cards] = cards 
      else 
        return_message[:status] = 'sorry - it appears you are not part of the game' 
        return_message[:cards] = [] 
      end 
    end 
    return_message.to_json 
  end 
#===============================
  post '/join' do 
    return_message = {} 

    puts params.to_s
    
    if params[:data] != nil # Neu POST tu code ruby
      puts "=> POST tu code ruby"
      jdata = JSON.parse(params[:data],:symbolize_names => true) 
    else  # Neu POST tu trinh duyet, javascript
      puts "=> POST tu trinh duyet, javascript"
      jdata = JSON.parse(params.to_json,:symbolize_names => true) 
    end

    puts jdata[:name].to_s

    if jdata.has_key?(:name) && uno.join_game(jdata[:name]) 
      return_message[:status] = 'welcome, ' + jdata[:name].to_s
    else 
      return_message[:status] = 'sorry - game not accepting more players' 
    end 
    return_message.to_json 
    
  end 
#===============================
  post '/deal' do 
    return_message = {} 
    if uno.deal 
      return_message[:status] = 'success' 
    else 
      return_message[:status] = 'fail' 
    end 
    return_message.to_json 
  end
#===============================
  put '/editname/:oldname/:newname' do 
    return_message = {} 
    
    if params[:data] != nil # Neu POST tu code ruby
      puts "=> POST tu code ruby"
      jdata = JSON.parse(params[:data],:symbolize_names => true) 
    else  # Neu POST tu trinh duyet, javascript
      puts "=> POST tu trinh duyet, javascript"
      jdata = JSON.parse(params.to_json,:symbolize_names => true) 
    end

    if jdata.has_key?(:oldname) && uno.edit_name(jdata[:oldname], jdata[:newname]) 
      return_message[:status] = 'Edit name thanh cong, name moi: ' + jdata[:newname].to_s
    else 
      return_message[:status] = 'error - ko ton tai user nay' 
    end 
    return_message.to_json 
  end 
#===============================
  delete '/removeuser' do  # co the dung /removeuser/:name, khi do se truyen tham so tren Url vi du http://localhost:8080/removeuser/Dung
    return_message = {} 
    
    #puts params.to_s
    
    if params[:data] != nil # Neu POST tu code ruby
      puts "=> POST tu code ruby"
      jdata = JSON.parse(params[:data],:symbolize_names => true) 
    else  # Neu POST tu trinh duyet, javascript
      puts "=> POST tu trinh duyet, javascript"
      jdata = JSON.parse(params.to_json,:symbolize_names => true) 
    end

    #puts jdata[:name].to_s

    if jdata.has_key?(:name) && uno.remove_user(jdata[:name]) 
      return_message[:status] = 'removed user: ' + jdata[:name].to_s
    else 
      return_message[:status] = 'error - ko ton tai user nay' 
    end 
    return_message.to_json 
  end 
#===============================

end

#UnoServer_Sinatra.run!
