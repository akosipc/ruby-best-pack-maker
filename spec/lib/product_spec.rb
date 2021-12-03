# typed: false
require 'spec_helper'

RSpec.describe Product, type: :lib do
  let!(:klass) do
    described_class.new(
      code: 'VS5',
      name: 'Vegemite Scroll',
      packs: [
        Pack.new(price: 6.99, quantity: 3, product_code: 'VS5'),
        Pack.new(price: 8.99, quantity: 5, product_code: 'VS5')
      ]
    )
  end

  describe '#suggested_price_for' do
    it 'raises an error when the packs is empty' do
      klass.instance_variable_set(:@packs, [])

      expect do
        klass.suggested_price_for(1)
      end.to raise_error(Product::InvalidInventory)
    end

    it 'raises an error when the pack does not support the inputted quantity' do
      expect do
        klass.suggested_price_for(444)
      end.to raise_error(Product::PackNotFound)
    end

    it 'returns the pack the has the quantity' do
      pack = klass.suggested_price_for(3)

      expect(pack).to be_instance_of Pack
      expect(pack.price).to eq 6.99
    end
  end
end
