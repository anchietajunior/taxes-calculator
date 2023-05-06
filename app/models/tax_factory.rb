# frozen_string_literal: true

require_relative 'basic_tax.rb'
require_relative 'imported_tax.rb'
require_relative 'imported_and_basic_tax.rb'
require_relative 'no_tax.rb'

class TaxFactory
  TAX_CLASSES = {
    [true, true] => ImportedAndBasicTax,
    [true, false] => BasicTax,
    [false, true] => ImportedTax
  }.freeze

  def self.create_tax(basic_taxed, imported)
    (TAX_CLASSES[[basic_taxed, imported]] || NoTax).new
  end
end
