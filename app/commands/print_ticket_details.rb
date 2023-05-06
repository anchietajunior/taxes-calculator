# frozen_string_literal: true

require_relative 'base_command'
class PrintTicketDetails < BaseCommand
  attr_reader :ticket_id, :repository

  def initialize(ticket_id, repository)
    @ticket_id = ticket_id.to_s
		@repository = repository
  end

  def call
		if ticket_data.nil?
			puts "No products found for the ticket with id: #{ticket_id}"
			return
		end

		ticket_data.each do |info|
			formatted_info = if info.size > 1
				info.map { |product_info| product_info.join(' ') + "\n" }.join
			else
				info.join(' ')
			end
			print formatted_info
		end
  end

	private

	def ticket_data
		@ticked_data ||= ticket_data = repository.retrieve_ticket_by_id(ticket_id)
	end
end
