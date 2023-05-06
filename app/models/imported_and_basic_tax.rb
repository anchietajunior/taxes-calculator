# frozen_string_literal: true

require_relative 'tax'

class ImportedAndBasicTax < Tax
  TAX = BigDecimal('0.15')

  def calculate(amount)
    round_up_to_nearest_0_or_5(amount * TAX)
  end
end
