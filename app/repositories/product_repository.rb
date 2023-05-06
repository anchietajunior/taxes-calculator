# frozen_string_literal: true

require 'csv'
require_relative '../../config'

class ProductRepository 
  def save_product(product)
    CSV.open(CSV_PATH, 'ab') { |csv| csv << product }
  end

  def persisted_product?(product)
    found = false
    CSV.foreach(CSV_PATH, headers: false) do |row|
      if row == product
        found = true
        break
      end
    end
    found
  end

  def retrieve_ticket_by_id(ticket_id)
    info = []
    products = []
    total_prices = 0
    total_taxes = 0
    CSV.foreach(CSV_PATH, headers: false) do |row|
      if row[0] == ticket_id
        products << row
        total_prices += row[-2].to_f
        total_taxes += row[-1].to_f
      end
    end

    puts 'No products found' if products.empty? && return

    info << products
    info << ["Sales Taxes: #{total_taxes}\n"]
    info << ["Total: #{total_prices}\n"]

    info
  end
end
