require "rubygems"
require "sequel"

DBmysql = Sequel.connect(:adapter=>'mysql2', :host=>'localhost', :database=>'whichs', :user=>'quantv', :password=>'xUqYEcsofvvB', :encoding=>'utf8')  #=> OK

puts "* Using Sequel - call Store procedure"

#output = 0
#DBmysql.call_sproc(:sp_update_username_email_photo, :args => [44, 'Van1', [:param_sp_success, 'int']])  # => thu nhieu cach van loi
#ds3 = DBmysql.fetch("CALL sp_update_username_email_photo(44 ,'Van1', @output_success); SELECT  @output_success;") # => update DB duoc nhung ko the tra ve output
#ds3.each{|row| puts row}