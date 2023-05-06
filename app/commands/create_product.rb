# frozen_string_literal: true

require 'pry'
require 'yaml'
require_relative 'base_command.rb'
require_relative '../models/tax_factory.rb'

class CreateProduct < BaseCommand
	attr_reader :product, :repository

	def initialize(product, repository)
    @product = product
		@repository = repository
  end
	
	def call
		save_product_to_csv
	rescue StandardError => e
		print "Could not save the product with error: #{e.message}, please try again.\n"
	end
	
	private
	
	def save_product_to_csv
		repository.save_product(product_to_row)
	end
	
	def product_to_row
		[
			product.ticket_id,
			product.quantity,
			product.name,
			total_price_with_taxes.to_s('F'),
			taxes
		]
	end

	def taxes
    @taxes ||= TaxFactory.create_tax(product.basic_taxed?, product.imported?).calculate(product.total_price)
  end
	
	def total_price_with_taxes
		(product.total_price + taxes).round(2)
	end
end
