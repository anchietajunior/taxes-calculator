# frozen_string_literal: true

require_relative 'app/models/product.rb'
require_relative 'app/commands/create_product.rb'
require_relative 'app/commands/print_ticket_details.rb'
require_relative 'app/repositories/product_repository.rb'

@ticket_id = nil
@repository = ProductRepository.new

def set_current_ticket(ticket_id)
	@ticket_id = ticket_id
end

def show_ticket_details(ticket_id)
	PrintTicketDetails.call(ticket_id, @repository)
end

loop do
	input = $stdin.gets.chomp.split(' ')
	operation_type = input.first

	if operation_type == "Input"
		set_current_ticket(input.last.split(':').first)
	end

	if operation_type == "Output"
		id = input.last.split(":").first
		show_ticket_details(id)
	end

	# When the input size is bigger than 3 it means we're adding a new product
	if input.size > 3
		product = Product.new(input, @ticket_id)
		CreateProduct.call(product, @repository)
		next
	end

	if operation_type == 'Exit'
		puts 'Exiting the app'
		break
	end
end
