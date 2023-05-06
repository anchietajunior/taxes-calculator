# frozen_string_literal: true

def stub_products_csv
  file_path = 'products_test.csv'
  File.delete(file_path) if File.exist?(file_path)
  stub_const('ProductRepository::CSV_PATH', file_path)
end
