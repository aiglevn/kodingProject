#$LOAD_PATH << '.'
#require "spec/spec_helper"
#require "idea.rb"

require_relative '../idea.rb'
require 'rack/test'
require 'rspec'

set :environment, :test

def app
	Sinatra::Application
end

describe 'Reverse Service' do
	include Rack::Test::Methods	

	it "should load the home page" do
		get '/nonereal'
		expect(last_response).to be_ok  # to_not
	end

	it "should reverse posted values as well" do
		post '/', params = { :str => 'Jeff'}
		expect(last_response.body).to eq 'ffeJ--'
	end
end