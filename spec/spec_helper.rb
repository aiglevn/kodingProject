require 'rack/test'
require 'rspec'

#require_relative "support/database_cleaner.rb" # xoa rong du lieu DB truoc khi chay test

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application 
  end
end

# module Helpers
#   def env( *methods )
#     methods.each_with_object({}) do |meth, obj|
#       obj.merge! __send__(meth)
#     end
#   end

#   def accepts_html
#     {"HTTP_ACCEPT" => "text/html" }
#   end

#   def accepts_json 
#     {"HTTP_ACCEPT" => "application/json" }
#   end

#   def via_xhr      
#     {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
#   end
# end

RSpec.configure do |c| 
  c.include RSpecMixin 
  # c.include Helpers, :type => :request
end

# RSpec.configure do |config|
#   config.include Helpers, :type => :request