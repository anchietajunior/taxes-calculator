# frozen_string_literal: true

require 'spec_helper'

require_relative '../../app/models/imported_tax.rb'

RSpec.describe ImportedTax do
  describe '#calculate' do
    it 'has the correct value' do
      expect(described_class.new.calculate(27.99)).to eq(1.4)
    end
  end
end
