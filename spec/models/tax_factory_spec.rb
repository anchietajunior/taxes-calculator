# frozen_string_literal: true

require 'spec_helper'

require_relative '../../app/models/tax_factory.rb'
require_relative '../../app/models/basic_tax.rb'
require_relative '../../app/models/imported_tax.rb'
require_relative '../../app/models/imported_and_basic_tax.rb'

RSpec.describe TaxFactory do
  subject(:tax_factory) { described_class.create_tax(basic_taxed, imported) }

  describe '.create_tax' do
    context 'when the basic_taxed is true and imported is false' do
      let(:basic_taxed) { true }
      let(:imported) { false }

      it 'returns an instance of BasicTax' do
        expect(tax_factory).to be_instance_of(BasicTax)
      end
    end

    context 'when the basic_taxed is true and imported is true' do
      let(:basic_taxed) { true }
      let(:imported) { true }

      it 'returns an instance of ImportedAndBasicTax' do
        expect(tax_factory).to be_instance_of(ImportedAndBasicTax)
      end
    end

    context 'when the basic_taxed is false and imported is false' do
      let(:basic_taxed) { false }
      let(:imported) { true }

      it 'returns an instance of ImportedTax' do
        expect(tax_factory).to be_instance_of(ImportedTax)
      end
    end
  end
end
