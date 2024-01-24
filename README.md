# User Converter

User Converter is a Ruby library for converting user data from JSON format to CSV.

## Installation

To use User Converter in your Ruby project, add the following line to your Gemfile:

```ruby
gem 'user_converter', '~> 0.1.0'
```

**Be sure to be located inside the `UserConverter` directory.** 

Then run:
```bash
bundle install
```

Alternatively, you can install the gem manually:

```bash
gem install user_converter -v 0.1.0
```

You may need to use `--user-install` at the end of the command if you don't have write permissions in the global gem installation directory.

## Usage
User Converter provides a simple interface to convert user data from a JSON file to a CSV file.

```ruby
require 'user_converter'

# Specify the paths for your JSON and CSV files
json_file_path = 'path/to/users.json'
csv_file_path = 'path/to/users.csv'

# Call the from_json_to_csv method
UserConverter::Converter.from_json_to_csv(json_file_path, csv_file_path)

# Print a message indicating successful execution
puts "Conversion completed successfully!"
```

Replace 'path/to/users.json' and 'path/to/users.csv' with the actual paths to your JSON input file and the desired CSV output file.

## Testing
To run the provided test script, execute the following command:

```ruby
ruby test/test_user_converter.rb
```

This script compares the generated CSV file with an expected CSV file to ensure the conversion works as expected. Ensure your expected CSV file (expected_users.csv) is correctly set up for testing.