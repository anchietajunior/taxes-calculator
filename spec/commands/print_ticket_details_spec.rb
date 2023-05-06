# frozen_string_literal: true

require 'rspec'

require_relative '../../app/repositories/product_repository.rb'
require_relative '../../app/commands/print_ticket_details.rb'
require_relative '../support/stub_products_csv'

RSpec.describe PrintTicketDetails do
  subject(:print_ticket) { described_class.call(ticket_id, repository) }
  let(:repository) { ProductRepository.new }

  before(:each) do
    stub_products_csv

    data = [
        [1, 2, 'book', 24.98, 0],
        [1, 1, 'music CD', 16.49, 1.5],
        [1, 1, 'chocolate bar', 0.85, 0],
        [2, 1, 'chocolate bar', 0.85, 0]
      ]

    CSV.open(ProductRepository::CSV_PATH, 'ab') do |csv|
      data.each do |row|
        csv << row
      end
    end
  end

  context 'when the ticket has 3 products' do
    let(:ticket_id) { 1 }
    
    it 'prints the correct information' do
      expect { print_ticket }.to output(
        "1 2 book 24.98 0\n1 1 music CD 16.49 1.5\n1 1 chocolate bar 0.85 0\nSales Taxes: 1.5\nTotal: 42.32\n"
      ).to_stdout
    end
  end

  context 'when the ticket has no products' do
    let(:ticket_id) { 4 }
    
    it 'prints the correct information' do
      expect { print_ticket }.to output(
        "No products found for the ticket with id: 4\n"
      ).to_stdout
    end
  end
end
