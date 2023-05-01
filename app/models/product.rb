# frozen_string_literal: true

require 'csv'

class Product
  NOT_TAXED_PRODUCTS = [
    'book',
    'chocolate',
    'chocolates',
    'pills'
  ]
  IMPORTED_TAX = 0.5
  BASIC_TAX = 0.10
  IMPORTED_AND_BASIC_TAX = 0.15

  attr_reader :name, :unit_price, :quantity, :ticket_id, :csv_path

  def initialize(input, ticket_id, csv_path)
    @quantity = input.first.to_i
    @name = input[1, input.length - 2].reject { |word| word == 'at' }.join(' ')
    @unit_price = input.last.to_f
    @ticket_id = ticket_id
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
    (total_price + taxes).round(2)
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
    tax *= 10
    rounded_tax = tax.ceil
    rounded_tax / 10.0
  end
end
