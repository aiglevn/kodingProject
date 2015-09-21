require "rubygems"
require "sequel"
#require 'mysql2'
#require 'data_objects'

#================================= connect to an in-memory database
DB = Sequel.sqlite

# create an items table
DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

# create a dataset from the items table
items = DB[:items]

# populate the table
items.insert(:name => 'abc', :price => rand * 100)
items.insert(:name => 'def', :price => rand * 100)
items.insert(:name => 'ghi', :price => rand * 100)

# print out the number of records
puts "* Using sequel - SQLite => Item count: #{items.count}"

# print out the average price
#puts "The average price is: #{items.avg(:price)}"

#================================== using Sequel
DBmysql = Sequel.connect(:adapter=>'mysql2', :host=>'localhost', :database=>'whichs', :user=>'quantv', :password=>'xUqYEcsofvvB', :encoding=>'utf8')  #=> OK
#DBmysql = Sequel.connect('do:mysql://quantv:xUqYEcsofvvB@localhost/whichs') #=> can require data_objects, mysql2: chi lay duoc cau truc bang, ko lay duoc du lieu ???

puts "* Using Sequel - gem mysql2"
ds = DBmysql.fetch("SELECT * FROM users where id in (1,2)")
ds.each{|r| puts r} 
#ds.each{|r| puts "Username : " + r[:username].to_s}

=begin
DBmysql.fetch("SELECT * FROM users where id = 1") do |row|
  puts row.to_s
end
=end

insert_ds = DBmysql["INSERT INTO users (username, email) VALUES (?, ?)", 'newUser' + Time.now.strftime("_%M_%S"), Time.now.strftime("_%H_%M_%S") + '@yahoo.com']
update_ds = DBmysql["UPDATE users SET email = ? WHERE id = ?", Time.now.strftime("_%H_%M_%S") + '@g.com', '1']
delete_ds = DBmysql["DELETE FROM users WHERE id >= ?", '14']

newId = insert_ds.insert
count_affectRows_u = update_ds.update
#count_affectRows_d = delete_ds.delete

#puts "count_affectRows_d: " + count_affectRows_d.to_s
puts "count_affectRows_u: " + count_affectRows_u.to_s
puts "newId: " + newId.to_s

#================================== using gem mysql2
# su dung api thuan cua mysql2 => OK 
puts "* Using gem mysql2"
client = Mysql2::Client.new(:host=>'localhost', :database=>'whichs', :username=>'quantv', :password=>'xUqYEcsofvvB')
results = client.query("SELECT * FROM users where id = 1")
results.each do |row|
  puts "ID : " + row["id"].to_s
  if row["username"] 
    puts "Username : " + row["username"].to_s
  end
end

=begin # USING SEQUEL WITH MODEL

where{column =~ nil}
Sequel.expr(:column1=>1) | {:column2=>2}
Sequel.|({:column1=>1}, {:column2=>2})
Sequel.or(:column1=>1, :column2=>2)
Sequel.negate(:column1=>1, :column2=>2) # (("column1" != 1) AND ("column2" != 2))
DB[:albums].exclude(:column1=>1, :column2=>2) # SELECT * FROM "albums" WHERE (("column" != 1) OR ("column2" != 2))
UserTable.find(:name=>'Bob') # SELECT * FROM artists WHERE (name = 'Bob') LIMIT 1
UserTable.find{name > 'M'} # SELECT * FROM artists WHERE (name > 'M') LIMIT 1

=end