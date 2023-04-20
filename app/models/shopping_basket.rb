# frozen_string_literal: true

require 'csv'

class ShoppingBasket
	CSV_PATH = 'products.csv'
	attr_reader :id

	def initialize(id)
		@id = id
	end

	def show_info
		info = []
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

		info << products
		info << ["Sales Taxes: #{total_taxes}\n"]
		info << ["Total: #{total_prices}\n"]

		info
	end
end
