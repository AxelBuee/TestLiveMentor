require 'user_converter'

# Specify the paths for your JSON and CSV files
json_file_path = File.expand_path('./files/users.json', __dir__)
csv_file_path = File.expand_path('./files/users.csv', __dir__)
expected_csv_file_path = File.expand_path('./files/expected_users.csv', __dir__)

# Call the from_json_to_csv method
UserConverter::Converter.from_json_to_csv(json_file_path, csv_file_path)

# Check if the generated CSV file is equal to the expected CSV file
generated_csv_content = File.read(csv_file_path)
expected_csv_content = File.read(expected_csv_file_path)

if generated_csv_content == expected_csv_content
    puts "Test passed: Generated CSV is equal to the expected CSV."
else
    puts "Test failed: Generated CSV is NOT equal to the expected CSV."
end