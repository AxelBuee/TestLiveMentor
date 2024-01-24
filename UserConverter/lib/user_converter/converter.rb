require 'json'
require 'csv'


module UserConverter
    class Converter
        def self.from_json_to_csv(json_file_path, csv_file_path)
            json_data = JSON.parse(File.read(json_file_path))
            header = generate_header(json_data)
            csv_lines = json_data.map do |user|
                flattened_keys = flatten_keys(user)
                generate_csv_line(user, flattened_keys)
            end
      
            write_csv_file(csv_file_path, header, csv_lines)
            puts "CSV file created at #{csv_file_path}"
        end
      
        private_class_method def self.flatten_keys(hash, prefix = nil)
            hash.flat_map do |k, v|
                new_key = prefix ? "#{prefix}.#{k}" : k.to_s
                if v.is_a?(Hash)
                flatten_keys(v, new_key)
                else
                new_key
                end
            end
        end
      
        private_class_method def self.generate_header(json_data)
            flattened_keys = json_data.flat_map { |user| flatten_keys(user) }.uniq
            flattened_keys.join(',')
        end
      
        private_class_method def self.process_value(value, key)
            if key == 'tags' && value.is_a?(Array)
                "\"#{value.join(',')}\""
            elsif value.nil?
                ''
            else
                value.is_a?(String) ? value : JSON.generate(value)
            end
        end
      
        private_class_method def self.generate_csv_line(user, flattened_keys)
            flattened_keys.map do |key|
                value = user.dig(*key.split('.'))
                process_value(value, key)
            end.join(',')
        end
      
        private_class_method def self.write_csv_file(csv_file_path, header, csv_lines)
            File.open(csv_file_path, 'w') do |file|
                file.puts header
                csv_lines.each { |line| file.puts line }
            end
        end
    end
end