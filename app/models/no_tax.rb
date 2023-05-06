# frozen_string_literal: true

require_relative 'tax'

class NoTax < Tax
  def calculate(amount)
    0
  end
end