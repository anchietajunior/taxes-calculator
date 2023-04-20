# frozen_string_literal: true

require 'csv'

class Product
  CSV_PATH = 'products.csv'
  NOT_TAXED_PRODUCTS = [
    'book',
    'chocolate',
    'chocolates',
    'pills'
  ]
  IMPORTED_TAX = 0.5
  BASIC_TAX = 0.10
  IMPORTED_AND_BASIC_TAX = 0.15

  attr_reader :name, :unit_price, :quantity, :shopping_basket

  def initialize(input, shopping_basket)
    @quantity = input.first.to_i
    @name = input[1, input.length - 2].reject { |word| word == 'at' }.join(' ')
    @unit_price = input.last.to_f
    @shopping_basket = shopping_basket
  end

  def save
    CSV.open(CSV_PATH, 'ab') do |csv|
      csv << to_row
    end
  end

  private

  def to_row
    [shopping_basket, quantity, name, total_price_with_taxes, taxes]
  end

  def imported?
    name.include?('imported')
  end

  def not_imported?
    !imported?
  end

  def not_taxed?
    name.split(' ').any? { |word| NOT_TAXED_PRODUCTS.include?(word) }
  end

  def taxed?
    !not_taxed?
  end

  def total_price
    @total_price ||= unit_price * quantity
  end

  def total_price_with_taxes
    round_up(total_price + taxes)
  end

  def taxes
    return 0 if product_tax.zero?

    round_up(total_price * product_tax)
  end

  def product_tax
    return IMPORTED_AND_BASIC_TAX if imported? && taxed?

    return BASIC_TAX if not_imported? && taxed?

    return IMPORTED_TAX if imported? && not_taxed?

    0
  end

  def round_up(tax)
    rounded_up = ((tax * 2).ceil) / 2.0
    rounded_up += 0.5 if rounded_up.to_s.split('.').last == '0'
    rounded_up
  end
end
