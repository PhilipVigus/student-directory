# instance variable on the global instance?
@students = []

def run_interactive_menu
  loop do
    print_menu
    process_selection(get_user_input)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def process_selection(selection)
  case selection
  when "1"
    get_students_from_user
  when "2"
    print_students
  when "3"
    save_students(get_filename_from_user)
  when "4"
    load_students_from_file(get_filename_from_user)
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def get_user_input
  STDIN.gets.chomp
end

def get_students_from_user
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = get_user_input
  # take names until the user inputs an empty name
  while !name.empty? do
    create_student(name, :november)
    puts "Now we have #{@students.count} students"
    name = get_user_input
  end
end

def create_student(name, cohort)
  @students << { name: name, cohort: cohort }
end

def print_students
  print_header
  print_student_list
  print_footer
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

def save_students(filename)
  if filename == ""
    puts "Unable to save file - you must provide a filename"
    return
  else
  # If the file doesn't exist this creates it before saving
  # w = write-only permission (for read-write it would be w+)
  # As we're using a block, we don't need to explicity close
  # the file, as it happens automatically when the block
  # finishes executing
    File.open(filename, "w") { |file| write_students_to_file(file) }
    puts "Students successfully saved to #{filename}"
  end
end

def write_students_to_file(file)
  @students.each do |student|
    # create an array from the data we want to save, then join the array
    # [name, cohort] => name,cohort
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    # writes the string to the file (cf puts, which is equiv to STDOUT.puts)
    file.puts csv_line
  end
end

def get_filename_from_user
  puts "Please enter the filename"
  get_user_input
end

def initialise_students
  filename = ARGV.first || "students.csv"
  load_students_from_file(filename)
end

def load_students_from_file(filename)
  if File.exists?(filename)
    # readlines reads the whole file and returns it as an array of individual lines
    File.open(filename, "r") { |file| create_students_from_file_lines(file.readlines) }
    puts "Students successfully loaded from #{filename}"
  else
    puts "Unable to load file - #{filename} does not exist"
  end
end

def create_students_from_file_lines(lines)
  lines.each do |line|
    name, cohort = line.chomp.split(",")  # parallel assignment
    create_student(name, cohort.to_sym)
  end
end

initialise_students
run_interactive_menu
