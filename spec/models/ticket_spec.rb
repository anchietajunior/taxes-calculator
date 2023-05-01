# frozen_string_literal: true

require 'spec_helper'
require 'csv'
require_relative '../../config'
require_relative '../../app/models/ticket'

RSpec.describe Ticket do
	subject(:ticket) { described_class.new(id, CSV_PATH).retrieve_data }

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
			products_list = ticket.first
			expect(products_list).to include(['1', '2', 'book', '24.98', '0'])
			expect(products_list).to include(['1', '1', 'music CD', '16.49', '1.5'])
			expect(products_list).to include(['1', '1', 'chocolate bar', '0.85', '0'])
			expect(ticket).to include(["Sales Taxes: 1.5\n"])
			expect(ticket).to include(["Total: 42.32\n"])
		end
	end
end
