require 'yaml'

def read_yaml_file(file_path)
  YAML.load_file(file_path)
end

file_path = 'not_taxed_products.yml'

hash_from_yaml = read_yaml_file(file_path)
puts hash_from_yaml.inspect