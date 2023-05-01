# frozen_string_literal: true

require_relative '../../config'

class ProductRepository
  attr_reader :input, :ticket_id

  def initialize(input = nil, ticket_id)
    @ticket_id = ticket_id
    @input = input
    pp "INTIALIZE PRODUCT REPOSITORY: #{CSV_PATH}"
  end

  def save
    p "SAVE"
  end

  def retrieve_ticket
    p "RETRIEVE"
  end
end
