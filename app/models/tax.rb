# frozen_string_literal: true

require 'bigdecimal'
class Tax
  def calculate(amount)
    raise NotImplementedError, "#{self.class} should implement the 'calculate' method"
  end

  def round_up_to_nearest_0_or_5(taxes)
		taxes *= 10
		rounded_tax = taxes.ceil
		rounded_tax / 10.0
	end
end
