# frozen_string_literal: true

require_relative 'config'
require_relative 'app/models/product'
require_relative 'app/models/ticket'

@ticket_id = nil

def set_current_ticket(ticket_id)
	@ticket_id = ticket_id
end

def show_ticket_details(ticket_id)
	PrintTicketDetails.new(ticket_id, CSV_PATH).call
end

loop do
	input = $stdin.gets.chomp.split(' ')
	operation_type = input.first

	if operation_type == "Input"
		set_current_ticket(input.last.split(':').first)
	end

	if operation_type == "Output"
		id = input.last.split(":").first
		show_ticket_details(ticket_id)
	end

	if input.size > 3
		Product.new(input, @ticket_id, csv_path).save
	end

	if operation_type == 'Exit'
		puts 'Exiting the app'
		break
	end
end
