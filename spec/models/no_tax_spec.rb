# frozen_string_literal: true

require 'spec_helper'

require_relative '../../app/models/no_tax.rb'

RSpec.describe NoTax do
  describe '#calculate' do
    it 'has the correct value' do
      expect(described_class.new.calculate(14.99)).to eq(0)
    end
  end
end
