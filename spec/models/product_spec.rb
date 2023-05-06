# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/product'

RSpec.describe Product do
  subject(:product) { described_class.new(input, ticket_id) }

	context 'when a product is not imported and does not have basic taxes' do
		let(:input) { ['2', 'book', 'at', '12.49'] }
		let(:ticket_id) { 1 }
		
		it 'has the correct values' do
			expect(product.quantity).to eq(2)
			expect(product.name).to eq('book')
			expect(product.unit_price).to eq(12.49)
			expect(product.ticket_id).to eq(1)
			expect(product.total_price).to eq(24.98)
		end
	end

	context 'when a product is not imported and have basic taxes' do
		let(:input) { ['1', 'music', 'CD', 'at', '14.99'] }
		let(:ticket_id) { 3 }

		it 'has the correct values' do
			expect(product.quantity).to eq(1)
			expect(product.name).to eq('music CD')
			expect(product.unit_price).to eq(14.99)
			expect(product.ticket_id).to eq(3)
			expect(product.total_price).to eq(14.99)
		end
	end
	
	context 'when a product is imported and have basic taxes' do
		let(:input) { ['1', 'imported', 'bottle', 'of', 'perfume', 'at', '27.99'] }
		let(:ticket_id) { 1 }

		it 'has the correct values' do
			expect(product.quantity).to eq(1)
			expect(product.name).to eq('imported bottle of perfume')
			expect(product.unit_price).to eq(27.99)
			expect(product.ticket_id).to eq(1)
			expect(product.total_price).to eq(27.99)
		end
	end
end
