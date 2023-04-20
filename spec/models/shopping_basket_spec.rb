# frozen_string_literal: true

require 'spec_helper'
require 'csv'
require_relative '../../app/models/shopping_basket'

RSpec.describe ShoppingBasket do
	subject(:info) { described_class.new(id).show_info }

	context 'showing results of a shopping basket' do
		let(:data) do
			[
				[1,2,'book',24.98,0],
				[1,1,'music CD',16.49,1.5],
				[1,1,'chocolate bar',0.85,0]
			]	
		end

		before do
			filename = 'products.csv'

			if File.exist?(filename)
				File.delete(filename)
			end

			CSV.open('products.csv', 'ab') do |csv|
				data.each do |row|
					csv << row
				end
			end
		end

		let(:id) { '1' }

		it 'has the correct values' do
			expect(info.first).to include(['1', '2', 'book', '24.98', '0']) 
			expect(info.first).to include(['1', '1', 'music CD', '16.49', '1.5']) 
			expect(info.first).to include(['1', '1', 'chocolate bar', '0.85', '0']) 
			expect(info).to include(["Sales Taxes: 1.5\n"]) 
			expect(info).to include(["Total: 42.32\n"]) 
		end
	end
end
