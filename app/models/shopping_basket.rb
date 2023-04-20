# frozen_string_literal: true

require 'csv'

class ShoppingBasket
	CSV_PATH = 'products.csv'
	attr_reader :id

	def initialize(id)
		@id = id
	end

	def print_info
		show_products
	end

	def show_products
		products = []
		total_prices = 0
		total_taxes = 0
		CSV.foreach(CSV_PATH, headers: false) do |row|
			if row[0] == id
				products << row
				total_prices += row[-2].to_f
				total_taxes += row[-1].to_f
			end
		end

		puts 'No products found' if products.empty? && return

		products.each do |product|
			product << "\n"
			print product.join(' ')
		end

		print "Sales Taxes: #{total_taxes}\n"
		print "Total: #{total_prices}\n"
	end
end
