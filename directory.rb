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

def print(students, filters)
  students.each_with_index do |student, index|
    # only display if no letter filter is set or the first letter of the name matches the filter
    first_letter_of_name = student[:name][0].downcase

    if filters == "" || first_letter_of_name == filters
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
filters = input_filters
print_header
print(students, filters)
print_footer(students)
