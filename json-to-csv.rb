require 'json'
require 'csv'

def json_to_csv(json_file, csv_file)
    # Parse the JSON file
    data = JSON.parse(File.read(json_file))
  
    # Extract headers
    headers = data.first.keys
  
    # Open the CSV file for writing
    CSV.open(csv_file, 'w') do |csv|
      # Write headers
      csv << headers
  
      # Write data
      data.each do |hash|
        csv << hash.map do |key, value|
          # Convert arrays and hashes to strings without extra quotes or brackets
          case value
          when Array then value.join(',')
          when Hash then value.map { |k, v| "#{k}:#{v}" }.join(',')
          else value
          end
        end
      end
    end
  end
  
# Call the function
json_to_csv('users.json', 'users.csv')