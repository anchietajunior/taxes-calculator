# frozen_string_literal: true

require 'spec_helper'

require_relative '../../app/models/basic_tax.rb'

RSpec.describe BasicTax do
  describe '#calculate' do
    it 'has the correct value' do
      expect(described_class.new.calculate(14.99)).to eq(1.5)
    end
  end
end
