$LOAD_PATH << '.'
require 'api/uno-client.rb'

user1_uno = UnoClient.new 'Dung'
user2_uno = UnoClient.new 'Nam'
user3_uno = UnoClient.new 'Ha cute'
user4_uno = UnoClient.new 'Minh'
user5_uno = UnoClient.new 'Ngoc'

user4_uno.join_game

#user4_uno.new('Minh').remove_user

=begin
user1_uno.join_game
user2_uno.join_game
user3_uno.join_game
user4_uno.join_game
#{:status=>"welcome"}
user5_uno.join_game
#{:status=>"sorry - game not accepting new players"}

user1_uno.deal
user1_uno.get_cards
user2_uno.get_cards
user3_uno.get_cards
user4_uno.get_cards
#{"cards":["4-club","7-club","3-club","king-heart","jack-club"]}
=end

=begin
	Trong Interactive ruby :
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