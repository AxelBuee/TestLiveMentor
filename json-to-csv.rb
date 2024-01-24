require 'json'
require 'csv'

json_file_path = 'users.json'
csv_file_path = 'users.csv'

json_data = JSON.parse(File.read(json_file_path))

# Method to recursively flatten the keys of nested hashes
def flatten_keys(hash, prefix = nil)
    hash.flat_map do |k, v|
        new_key = prefix ? "#{prefix}.#{k}" : k.to_s
        v.is_a?(Hash) ? flatten_keys(v, new_key) : new_key
    end
end
  
# Extract unique flattened keys from the JSON data
flattened_keys = json_data.flat_map { |user| flatten_keys(user) }.uniq

# Create the header string
header = flattened_keys.join(',')

# Open the file in write mode and write CSV lines
File.open(csv_file_path, 'w') do |file|
    # Write CSV header
    file.puts header

    # Write CSV lines
    json_data.each do |user|
        csv_line = flattened_keys.map do |key|
        value = user.dig(*key.split('.'))
        if key == 'tags' && value.is_a?(Array)
            "\"#{value.join(',')}\""
        else
            value
        end
        end.join(',')
        file.puts csv_line
    end
end

puts "CSV file created at #{csv_file_path}"