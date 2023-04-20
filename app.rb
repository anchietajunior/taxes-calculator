# frozen_string_literal: true
#

require_relative 'app/models/product'
require_relative 'app/models/shopping_basket'

@shopping_basket = nil

loop do
	input = $stdin.gets.chomp.split(" ")

	if input.first == "Input"
		@shopping_basket = input.last.split(":").first
	end

	if input.first == "Output"
		id = input.last.split(":").first
		ShoppingBasket.new(id).show_products
	end

	if input.size > 3
		Product.new(input, @shopping_basket).save
	end

	if input == 'exit'
		puts 'Exiting the app'
		break
	end
end
