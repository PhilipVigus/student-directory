def input_students
  puts "Please enter the names and cohorts of the students"
  puts "If cohort is left blank, the closest cohort (March) will be used"
  puts "To finish, just enter a blank name"

  students = []

  loop do
    puts "Name: "
    name = gets.chomp
    # return if no name is given
    return students if name == ""

    puts "Cohort: "
    cohort = gets.chomp
    # set a default if no cohort is given
    if cohort == ""
      cohort = :march
    else
      cohort = cohort.downcase.to_sym
    end

    students << { name: name, cohort: cohort }
  end

  # return students
  students
end

def input_first_letter_filter
  puts "Please input a starting letter to filter the names by (leave empty for no filter)"

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

def input_name_length_filter
  puts "Do you want to show only names with less than 12 letters (y/n)?"

  loop do
    filter_by_length = gets.chomp.downcase

    if filter_by_length == 'y'
      return true
    elsif filter_by_length == 'n'
      return false
    else
      puts "You must enter either 'y' or 'n'"
    end
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students, first_letter_filter, filter_by_name_length)
  # check to see if we need to filter by the first letter
  if first_letter_filter != ""
    filtered_students = filter_names_by_first_letter(students, first_letter_filter)
  else
    filtered_students = students.dup
  end

  # check to see if we need to filter out names > 11 in length
  if filter_by_name_length
    filtered_students = filter_names_by_length(filtered_students)
  end

  filtered_students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def filter_names_by_first_letter(students, first_letter_filter)
  # compare the first letter of the name to the letter filter
  students.select { |student| student[:name][0].downcase == first_letter_filter }
end

def filter_names_by_length(students)
  students.select { |student| student[:name].length < 12 }
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
first_letter_filter = input_first_letter_filter
filter_by_name_length = input_name_length_filter
print_header
print(students, first_letter_filter, filter_by_name_length)
print_footer(students)
