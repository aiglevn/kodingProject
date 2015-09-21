# puts "Hello, My first code !"
class Employee
  def initialize(name, salary, hire_year)
    @name = name
    @salary = salary
    @hire_year = hire_year
  end
  
  def to_s
    "Name is #{@name}, salary is #{@salary}, " +
      "hire year is #{@hire_year}"
  end
  
  def raise_salary_by(perc)
    @salary += (@salary * 0.10)
    
  end
end

class Manager < Employee
  def initialize(name, salary, hire_year, asst)
    super(name, salary, hire_year)
    @asst = asst
  end
  
  def to_s
    super + ",\tAssistant info #{@asst}"
  end
  
  def raise_salary_by(perc)
    perc += 2005 - @hire_year
    super(perc)
  end
end

if __FILE__ == $0 #neu day la file duoc dung de chay app
  mg = Manager.new("DungPt", 2000, 2, "Manh Hieu")
  mg.raise_salary_by(2010)

  puts mg.to_s()
end