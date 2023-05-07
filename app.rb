# frozen_string_literal: true

require_relative 'app/models/product.rb'
require_relative 'app/commands/create_product.rb'
require_relative 'app/commands/print_ticket_details.rb'
require_relative 'app/repositories/product_repository.rb'
class App
	attr_accessor :ticket_id, :repository

	def initialize
		@ticket_id = 0
		@repository = ProductRepository.new
	end

	def run
		loop do
			input = $stdin.gets.chomp.split(' ')
			break if input.size > 0 && input.first == 'Exit'
			handle_input(input)
		end
	end

	private

	def handle_input(input)
		operation_type = input.first

		set_current_ticket(input.last.split(':').first) if operation_type == "Input"

		if operation_type == "Output"
			id = input.last.split(":").first
			show_ticket_details(id)
		end

		if input.size > 3
			product = Product.new(input, @ticket_id)
			CreateProduct.call(product, repository)
		end
	end

	def set_current_ticket(ticket_id)
		@ticket_id = ticket_id
	end

	def show_ticket_details(ticket_id)
		PrintTicketDetails.call(ticket_id, @repository)
	end
end

App.new.run
