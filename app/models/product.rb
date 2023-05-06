# frozen_string_literal: true

require 'csv'
require 'bigdecimal'

class Product
  attr_reader :name, :unit_price, :quantity, :ticket_id, :total_price

  def initialize(input, ticket_id)
    @quantity = input.first.to_i
    @name = input[1, input.length - 2].reject { |word| word == 'at' }.join(' ')
    @unit_price = BigDecimal(input.last)
    @ticket_id = ticket_id
    @total_price = @unit_price * @quantity
  end

  def imported?
    name.include?('imported')
  end

  def basic_taxed?
    name.split(' ').none? { |word| not_taxed_products_list.include?(word) }
  end

  private

  def not_taxed_products_list
    YAML.load_file('not_taxed_products.yml')['not_taxed']
  end
end
