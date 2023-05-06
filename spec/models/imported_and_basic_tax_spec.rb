# frozen_string_literal: true

require 'spec_helper'

require_relative '../../app/models/imported_and_basic_tax.rb'

RSpec.describe ImportedAndBasicTax do
  describe '#calculate' do
    it 'has the correct value' do
      expect(described_class.new.calculate(27.99)).to eq(4.2)
    end
  end
end
