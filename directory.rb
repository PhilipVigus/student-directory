def input_students
  puts "Please enter the names and personal details of the students"
  puts "If you make a mistake with a name or cohort, enter DELETE for the next student name. This will delete the last student you entered"
  puts "To finish, just enter a blank name"

  students = []

  loop do
    puts "Name?"
    name = gets.chomp

    if name == "DELETE"
      if students.length == 0
        puts "There are no students to delete"
      else
        # delete the last student that was entered and go
        # to the next iteration so we ask for another name
        puts "The last record: Name - #{students[-1][:name]}, Cohort - #{students[-1][:cohort]}, has been deleted"
        students.pop()
      end

      next
    elsif name == ""
      # the user has entered a blank name, so they've finished
      # return the array of students
      return students
    end

    cohort = input_additional_student_info("Cohort?", "March").downcase.to_sym
    country = input_additional_student_info("Country of birth?", "UK")
    school = input_additional_student_info("Previous school?", "n/a")

    students << { name: name, cohort: cohort, country: country, school: school }
  end

  # return students
  students
end

def input_additional_student_info(prompt, default="")
  puts default == "" ? prompt : prompt + " (Defaults to #{default} if none given)"
  response = gets.chomp
  return response == "" ? default : response
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

def name_length_filter?
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
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort) #{student[:country]} #{student[:school]}"
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
filter_by_name_length = name_length_filter?
print_header
print(students, first_letter_filter, filter_by_name_length)
print_footer(students)
