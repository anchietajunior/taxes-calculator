# frozen_string_literal: true

require 'rspec'
require_relative '../../app/repositories/product_repository'
require_relative '../support/stub_products_csv'

RSpec.describe ProductRepository do
  subject(:repository) { described_class.new }

  before(:each) do
    stub_products_csv
  end

  describe '.save_product' do
    context 'when the product has no taxes' do
      let(:product) { ['1', '2', 'book', '24.98', '0'] }
      let!(:save_product) { repository.save_product(product) }

      it 'saves the product with the correct values' do
        expect(repository.persisted_product?(product)).to eq(true)
      end
    end

    context 'when the product is not imported and have basic taxes' do
      let(:product) { ['1', '1', 'music CD', '16.49', '1.5'] }
      let!(:save_product) { repository.save_product(product) }

      it 'saves the product with the correct values' do
        expect(repository.persisted_product?(product)).to eq(true)
      end
    end
  end

  describe '.retrieve_ticket_by_id' do
    context 'when ticket exists and there is products with taxes' do
      before do
        # Populate products_test.csv
        data = [[1, 2, 'book', 24.98, 0], [1, 1, 'music CD', 16.49, 1.5], [1, 1, 'chocolate bar', 0.85, 0]]

        CSV.open(ProductRepository::CSV_PATH, 'ab') do |csv|
          data.each do |row|
            csv << row
          end
        end
      end

      subject(:ticket) { described_class.new.retrieve_ticket_by_id(ticket_id) }

      let(:ticket_id) { '1' }

      it 'has the correct data' do
        expect(described_class::CSV_PATH).to eq('products_test.csv')

        products_list = ticket.first
        expect(products_list).to include(['1', '2', 'book', '24.98', '0'])
        expect(products_list).to include(['1', '1', 'music CD', '16.49', '1.5'])
        expect(products_list).to include(['1', '1', 'chocolate bar', '0.85', '0'])
        expect(ticket).to include(["Sales Taxes: 1.5\n"])
        expect(ticket).to include(["Total: 42.32\n"])
      end
    end
  end
end
