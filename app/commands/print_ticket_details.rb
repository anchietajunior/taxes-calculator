# frozen_string_literal: true

require_relative '../models/ticket'

class PrintTicketDetails
  attr_reader :ticket_id, :csv_path

  def initialize(ticket_id, csv_path)
    @ticket_id = ticket_id
		@csv_path = csv_path
  end

  def call
    ticket_data = Ticket.new(ticket_id, csv_path).retrieve_data
		ticket_data.each do |info|
			if info.size > 1
				info.each do |product_info|
					product_info << "\n"
					print product_info.join(' ')
				end
			else
				print info.join(' ')
			end
		end
  end
end
