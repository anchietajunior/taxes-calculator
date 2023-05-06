# frozen_string_literal: true

require_relative 'tax'

class ImportedTax < Tax
  TAX = BigDecimal('0.05')

  def calculate(amount)
    round_up_to_nearest_0_or_5(amount * TAX)
  end
end