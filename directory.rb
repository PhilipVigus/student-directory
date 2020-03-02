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

def input_first_letter_filter
  puts "Please input a starting letter to filter the names by (press enter to ignore)"

  # loop until we get a valid letter filter
  loop do
    letter_filter = gets.chomp
    # only return if the filter is "" or a single character
    if letter_filter.length < 2
      return letter_filter.downcase
    else
      puts "The filter must be either empty or a single character"
    end
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students, first_letter_filter)
  # check to see if we need to filter by the first letter
  if first_letter_filter != ""
    filtered_students = filter_names_by_first_letter(students, first_letter_filter)
  else
    filtered_students = students.dup
  end

  filtered_students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def filter_names_by_first_letter(students, first_letter_filter)
  # compare the first letter of the name to the letter filter
  students.select { |student| student[:name][0].downcase == first_letter_filter }
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
first_letter_filter = input_first_letter_filter
print_header
print(students, first_letter_filter)
print_footer(students)
