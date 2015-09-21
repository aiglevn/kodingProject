require 'sequel'
require 'json'

Sequel.connect(:adapter=>'mysql2', :host=>'localhost', :database=>'whichs_koding', :user=>'root', :password=>'msA!23456', :encoding=>'utf8')

class Sequel::Model
  self.plugin :json_serializer
end

class Users < Sequel::Model  # table name

end

class Comments < Sequel::Model  # table name

end