# frozen_string_literal: true

require 'rspec'
require 'pry'
require_relative '../../app/models/product.rb'
require_relative '../../app/repositories/product_repository.rb'
require_relative '../../app/commands/create_product.rb'
require_relative '../support/stub_products_csv'

RSpec.describe CreateProduct do
  subject(:create_product) { described_class.call(product, repository) }
  let(:repository) { ProductRepository.new }

  before(:each) do
    stub_products_csv

    CSV.open(ProductRepository::CSV_PATH, 'ab')
  end

  describe '.call' do
    context 'when the product is imported and basic taxed' do
      let(:product) { Product.new(['2', 'imported', 'bottle', 'of', 'perfume', 'at', '27.99'], 1) }
      let(:saved_product) { ['1','2','imported bottle of perfume', '64.38', '8.4'] }

      it 'saves the product with the correct values' do
        create_product
        expect(repository.persisted_product?(saved_product)).to eq(true)
      end
    end

    context 'when the product has no taxes' do
      let(:product) { Product.new(['2', 'book', 'at', '15.0'], 2) }
      let(:saved_product) { ['2', '2', 'book', '30.0', '0'] }

      it 'saves the product with the correct values' do
        create_product
        expect(repository.persisted_product?(saved_product)).to eq(true)
      end
    end
  end
end
