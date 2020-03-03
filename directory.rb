# instance variable on the global instance?
@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = gets.chomp
  # take names until the user inputs an empty name
  while !name.empty? do
    @students << { name: name, cohort: :november }
    puts "Now we have #{@students.count} students"
    name = gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  # opens the file. If it doesn't exist it creates it
  # w = write-only permission (for read-write it would be w+)
  file = File.open("students.csv", "w")

  @students.each do |student|
    # create an array from the data we want to save, then join the array
    # [name, cohort] => name,cohort
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    # writes the string to the file (cf puts, which is equiv to STDOUT.puts)
    file.puts csv_line
  end

  file.close
end

def load_students
  # opens in write mode
  file = File.open("students.csv", "r")
  # readlines reads the whole file and returns it as an array of individual lines
  file.readlines.each do |line|
    # chomp gets rid of the trailing \n
    name, cohort = line.chomp.split(",")  # parallel assignment
    @students << { name: name, cohort: cohort.to_sym}
  end

  file.close
end

interactive_menu
