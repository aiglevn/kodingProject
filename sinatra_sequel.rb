require "rubygems"
require "sequel"

DBmysql = Sequel.connect(:adapter=>'mysql2', :host=>'localhost', :database=>'whichs', :user=>'quantv', :password=>'xUqYEcsofvvB', :encoding=>'utf8')  #=> OK

puts "* Using Sequel - call Function"
ds = DBmysql.fetch("SELECT * FROM users where id in (1,2)")
#ds.each{|r| puts "Username : " + r[:username].to_s}

items = []
#ds2 = DBmysql.fetch(DBmysql.literal(Sequel.function(:getUserWithMaxFollows => 10)).to_s)
#ds2 = Sequel.function(:getUserWithMaxFollows, :maxUserId, 10)
ds2 = DBmysql.fetch("select getUserWithMaxFollows(10) AS countMaxFollows")
#items.literal(Sequel.function(:getUserWithMaxFollows, 10))
ds2.each{|row| puts row[:countMaxFollows].to_s}


puts "* Using Sequel - call Store procedure"

#output = 0
#DBmysql.call_sproc(:sp_update_username_email_photo, :args => [44, 'Van1', [:param_sp_success, 'int']])  # => thu nhieu cach van loi
ds3 = DBmysql.fetch("CALL sp_update_username_email_photo(44 ,'Van1', @output_success)") # => update DB duoc nhung ko the tra ve output
ds3.each{|row| puts row}


puts "* Using Sequel - using transaction"
userid = '131'
DBmysql.transaction do
  begin
    update_ds1 = DBmysql["UPDATE users SET username = ? WHERE id = ?", 'Nam7', userid]
    update_ds2 = DBmysql["UPDATE users SET email = ? WHERE id = ?", 'nam7@g.com', userid]

    count_affectRows_u1 = update_ds1.update
    count_affectRows_u2 = update_ds2.update

    puts "count_affectRows_u1: " + count_affectRows_u1.to_s
    puts "count_affectRows_u2: " + count_affectRows_u2.to_s
    rescue => e
      puts "system error: " + e.message
      raise(Sequel::Rollback) # if ...
  end
    
end


=begin
	
# DROP FUNCTION getUserWithMaxFollows;
DELIMITER $$
CREATE FUNCTION getUserWithMaxFollows(maxUserId int)
  RETURNS int
  LANGUAGE SQL
BEGIN
	DECLARE count INT;
    SET count = 0;
    select max(totalFollows) into count from
					(
					select username, count(follower_id) as 'totalFollows' from users u join follows f on u.id = f.user_id
                    where user_id <= maxUserId
					group by username
					) bang1;
  RETURN count;
END;
$$
DELIMITER ;

# select getUserWithMaxFollows(10) AS countMaxFollows FROM DUAL;

#===========================================

# DROP PROCEDURE sp_update_username_email_photo;
DELIMITER $$
CREATE PROCEDURE sp_update_username_email_photo(IN p_userid int, IN p_newUsername text, OUT param_sp_success TINYINT)
BEGIN
DECLARE exit handler for sqlexception
  BEGIN
    -- ERROR
	SET param_sp_success = -1;
  ROLLBACK;
END;

DECLARE exit handler for sqlwarning
 BEGIN
    -- WARNING
    SET param_sp_success = -2;
 ROLLBACK;
END;

SET param_sp_success = 0;

START TRANSACTION;

update users set username = p_newUsername where id = p_userid;
update users set email = concat(p_newUsername, '@g.com') where id = p_userid;
update users set photo = concat(p_newUsername, '_photo') where id = p_userid;

COMMIT;
SET param_sp_success = 1;
END
$$
DELIMITER ;

# CALL sp_update_username_email_photo(44 ,'Van1', @output_success); SELECT  @output_success;
	
=end