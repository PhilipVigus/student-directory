def interactive_menu
  students = []
  loop do
    # print the menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    # get the user input
    selection = gets.chomp
    # do what they asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []
  name = gets.chomp

  # take names until the user inputs an empty name
  while !name.empty? do
    students << { name: name, cohort: :november }
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end

  # return students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

interactive_menu
