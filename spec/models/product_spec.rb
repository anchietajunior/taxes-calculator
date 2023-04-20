# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/product'

RSpec.describe Product do
	subject(:product) { described_class.new(input, shopping_basket) }

	context 'when a product is not imported and does not have basic taxes' do
		let(:input) { ['2', 'book', 'at', '12.49'] }
		let(:shopping_basket) { 1 }

		it 'has the correct values' do
			expect(product.send(:to_row).join(' ')).to eq("1 2 book 24.98 0")
		end
	end

	context 'when a product is not imported and have basic taxes' do
		let(:input) { ['1', 'music', 'CD', 'at', '14.99'] }
		let(:shopping_basket) { 1 }

		it 'has the correct values' do
			expect(product.send(:to_row).join(' ')).to eq("1 1 music CD 16.49 1.5")
		end
	end

	context 'when a product is imported and have basic taxes' do
		let(:input) { ['1', 'imported', 'bottle', 'of', 'perfume', 'at', '27.99'] }
		let(:shopping_basket) { 1 }

		it 'has the correct values' do
			expect(product.send(:to_row).join(' ')).to eq("1 1 imported bottle of perfume 32.19 4.2")
		end
	end
end
