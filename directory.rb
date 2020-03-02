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

def input_filters
  filter_set = false
  puts "Please input a starting letter to filter the names by (press enter to ignore)"

  while !filter_set do
    letter_filter = gets.chomp

    # only return if the filter is "" or a single character
    if letter_filter.length < 2
      return letter_filter
    else
      puts "The filter must be either empty or a single character"
    end
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
filters = input_filters
print_header
print(students)
print_footer(students)
