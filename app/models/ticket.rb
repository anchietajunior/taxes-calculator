# frozen_string_literal: true

require 'csv'

class Ticket
	attr_reader :id, :csv_path

	def initialize(id, csv_path)
		@id = id
		@csv_path = csv_path
	end

	def retrieve_data
		info = []
		products = []
		total_prices = 0
		total_taxes = 0
		CSV.foreach(csv_path, headers: false) do |row|
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
