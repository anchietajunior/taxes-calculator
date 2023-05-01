# frozen_string_literal: true

require 'rspec'
require_relative '../../app/repositories/product_repository'

RSpec.describe ProductRepository do
  describe '.create' do
    subject(:create) { described_class.new(ticket_id) }

    let(:ticket_id) { "1" }

    it "is ok" do
      subject.save
    end
  end

  describe '.retrieve_ticket' do
    subject(:create) { described_class.new(ticket_id) }

    let(:ticket_id) { "1" }

    it "is ok" do
      subject.retrieve_ticket
    end
  end
end
