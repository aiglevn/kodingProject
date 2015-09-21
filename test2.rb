$LOAD_PATH << '.'
$KCODE = 'u'

require 'checkValid'
require 'calculate.rb'
require 'scanf'

=begin
puts "Ten ban la gi ?"
input = gets
print "Xin chao, "
print input
=end

$global_variable = 10
class Class1
	@@classVar1 = "class Var"
	
 def print_global
   $global_variable = 20
   @@classVar1 = "class Var 2"
   puts "Global variable in Class1 is #$global_variable"
 end

 def print_classVar   
 	@insVar1 = "instance Var 8"   
   puts "Class variable in Class1 is: #@@classVar1"
 end

 def print_insVar
 	@insVar1 = "instance Var 9"   
   puts "Instance variable in Class1 is: #@insVar1"
 end

 def useArray
 	ary = [  "fred", 10, 3.14 ]
	ary.each do |i|
	   puts i
	end

	hsh = colors = { "red" => 0xf00, "green" => 0x0f0, "blue" => 0x00f }
	hsh.each do |key, value|
	   #print key, " is ", value, "\n"
	   puts key.to_s + " is " + value.to_s
	end

	(10..15).each do |n| 
	   print n, ' ' 
	end

	puts
	puts "2**3 = #{2**3}"

	puts (1..10) === 5 #check contain, 1...10 Creates a range from 1 to 9, 1..10 => 1 - 10
	puts ('a'...'e') === 'c'

	a = 10
	b = 20
	c = 30
	a, b = b, c # a = b ; b = c
	puts "a => #{a} ; b => #{b} ; c => #{c}"

	$var =  true
	print "1 -- Value is set\n" if $var
	print "2 -- Value is set\n" unless $var

	$var = false
	print "3 -- Value is set\n" unless $var

	$i = 0
	$num = 5
	while $i < $num  do
	   puts("Inside the loop i = #$i" )
	   $i +=1
	end

	for i in 'a'..'c'
	   puts "Value of local variable is #{i}"
	end

	def funTest
	   i = 100
	   j = 200
	   k = 300
	   yield 6,7
	   puts 'end of funTest'
	return i, j, k
	end

	varArr = funTest {|a,b| puts "in block #{a}, #{a + b}"}
	dem = 0
	varArr.each do |prso|
		varArr[dem] += 5
		dem += 1
	end
	puts varArr

	undef funTest
	#varArr = funTest => error

	puts CheckValidate.isSoChan(78)
	puts Calculate.tinhTong(12, 3)

	chuoi1 = "David"
	chuoi2 = 'This is a simple Ruby string literal';

	puts chuoi1
	puts chuoi2

	puts "~" + %{Ruby is fun. } + "~"
	puts "~" + "Ruby is fun. \t" + "~"

	myStr = String.new("THIS IS TEST")
	foo = myStr.downcase
	puts chuoi1.downcase
	puts "#{foo}"

	breed = "Spaniel"
	size = 65
	result = "Breed %{b} size %{z}" % {b: breed, z: size}
	p result

	#arrNew = "123 456".block_scanf("%d") #=> error ????
	arrNew = "123 456".scanf("%d%d")	
	puts arrNew

	p String.try_convert("abc")
	p String.try_convert(4)

	p "ka ".concat(" ki")
	a = "hello"
	a << " world"
	p a

	p "abcd" <=> "abcdc"
	"abcdef".casecmp("ABCDEF")    #=> 0
	p "" == 22

	p "cat o' 9 tails" =~ /\d/  #regular express, return match position 
	
	a = "hello there"
	p a[1]                   #=> "e"
	p a[2, 3]                #=> "llo"	
	p a[7..-2]               #=> "her"
	p a[-4..-2]              #=> "her"
	p a[-2..-4]              #=> ""
	p a[12..-1]              #=> nil
	a[/[aeiou](.)\1/]      #=> "ell"
	a[/[aeiou](.)\1/, 0]   #=> "ell"
	a[/[aeiou](.)\1/, 1]   #=> "l"
	a[/[aeiou](.)\1/, 2]   #=> nil
	a["lo"]                #=> "lo"
	a["bye"]               #=> nil

	p "hello".capitalize    #=> "Hello"
	a.capitalize! #modify a
	p a

	p "hello".center(11, '@~') #=> "@~@hello@~@"
	p "hello".each_char {|c| print c, '*' }
	p "hello\r\n".chomp        #=> "hello"
	p "hello  ".chomp(" ")

	p a = "hello world Q"
	p a.count "lo"            #=> 5
	p a.count "lo", "o"       #=> 2
	p a.count "hello", "^l"   #=> 4
	p a.count "j-rm"          #=> 4 ?????

	p "hello".delete "l","lo"        #=> "heo" - xoa cac ky tu giao nhau giua 2 mang ['l'] va ['l','o']
	p "hello".delete "lo"            #=> "he" - xoa cac ky tu trong mang ['l','o']
	p "hello".delete "aeiou", "^e"   #=> "hell" ?????
	p "hello".delete "ej-m"          #=> "ho" - xoa cac ky tu thuoc 1 trong 2 mang ['e'] va ['j'..'m']

	"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
	"hello".gsub(/([aeiou])/, '<\1>')             #=> "h<e>ll<o>"
	'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"

	"hello".index('e')             #=> 1
	"hello".index('lo')            #=> 3
	"hello".index('a')             #=> nil
	"hello".index(?e)              #=> 1

	p "hello world".replace "world"   #=> "world"

	"abcd".insert(0, 'X')    #=> "Xabcd"
	"abcd".insert(-3, 'X')   #=> "abXcd" - vi tri thu 3 tu ben phai sang (bat dau chi so la 1)

	str = "hello"
	str[3] = "\b"
	p str.inspect       #=> "\"hel\\bo\"" - them cac ky tu escape sequence de in ra duoc

	p 'hello world'.match('\s+\w+o{1}') #regular express

	" now's  the time".split(' ')   #=> ["now's", "the", "time"]
	" now's  the time".split(/ /)   #=> ["", "now's", "", "the", "time"]
	"hello".split(//)               #=> ["h", "e", "l", "l", "o"]

	"mellow yellow".split("ello")   #=> ["m", "w y", "w"]
	p "1,2,,3,4,,".split(',')         #=> ["1", "2", "", "3", "4"]
	"1,2,,3,4,,".split(',', 4)      #=> ["1", "2", "", "3,4,,"] - 4 ky tu dau tien

	"    hello    ".strip   #=> "hello"  => as trim() in .net
	"\tgoodbye\r\n".strip   #=> "goodbye"  => as trim() in .net

	names = Array.new
	names = Array.new(20)
	nums = Array[1, 2, 3, 4, 5]
	p nums.at(3)

	months = Hash.new
	months = Hash.new("month")
	hash1 = Hash["a" => 100, "b" => 200]
	puts "#{hash1['a']}"

	time1 = Time.new #=> Time.now
	puts "Current Time : " + time1.inspect
	puts time1.strftime "%Y-%m-%d %H:%M:%S %z"
	puts Time.now.strftime("_%M_%S")

	# Here is the interpretation
	p time1.zone       # => "UTC": return the timezone
	p time1.utc_offset # => 0: UTC is 0 seconds offset from UTC
#-------------
 end

end

class Class2
  def print_global
    $global_variable = 30
    @@classVar1 = "class Var 3"
    localVar = 999
    puts "Global variable in Class2 is #$global_variable"
    puts "localVar in Class2 is #{localVar + 2}"
  end
end

class1obj = Class1.new
class1obj.useArray
#class1obj.print_global
#class1obj.print_classVar
#class1obj.print_insVar

class2obj = Class2.new
#class2obj.print_global