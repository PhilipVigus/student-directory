def print_my_own_source_code
  this_file_name = $PROGRAM_NAME
  File.open(this_file_name, "r") do |file|
    file.readlines.each { |line| puts line }
  end
end

print_my_own_source_code
