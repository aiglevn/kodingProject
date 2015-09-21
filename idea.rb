require 'sinatra'

def reverse string
	string.each_char.to_a.reverse.join
end

get '/' do
	'Hello World -'
end

get '/nonereal' do
	'There we go.'
end

post '/' do
	reverse params[:str]
end