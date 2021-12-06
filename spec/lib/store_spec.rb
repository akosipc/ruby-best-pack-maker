# typed: false
require 'spec_helper'

RSpec.describe Store, type: :lib do
  let!(:store) do
    described_class.new(products: [
                          Product.new(
                            name: 'Vegemite Scroll',
                            code: 'VS5',
                            packs: [
                              Pack.new(price: 6.99, quantity: 3, product_code: 'VS5'),
                              Pack.new(price: 8.99, quantity: 5, product_code: 'VS5')
                            ]
                          ),
                          Product.new(
                            name: 'Blueberry Muffin',
                            code: 'MB11',
                            packs: [
                              Pack.new(price: 9.95, quantity: 2, product_code: 'MB11'),
                              Pack.new(price: 16.95, quantity: 5, product_code: 'MB11'),
                              Pack.new(price: 24.95, quantity: 8, product_code: 'MB11')
                            ]
                          ),
                          Product.new(
                            name: 'Croissant',
                            code: 'CF',
                            packs: [
                              Pack.new(price: 5.95, quantity: 3, product_code: 'CF'),
                              Pack.new(price: 9.95, quantity: 5, product_code: 'CF'),
                              Pack.new(price: 16.99, quantity: 9, product_code: 'CF')
                            ]
                          )
                        ])
  end

  describe '#buy' do
    context 'when the product_code is VS5 and quantity is 10' do
      it 'returns an order with order items for the packs' do
        output = store.buy('VS5', 10)

        expect(output).to be_instance_of Order
        expect(output.order_items.length).to eq 1
        expect(output.order_items[0].quantity).to eq 2
        expect(output.order_items[0].pack.quantity).to eq 5
      end
    end

    context 'when the product_code is MB11 and quantity is 14' do
      it 'returns an order with order items for the packs' do
        output = store.buy('MB11', 14)

        expect(output).to be_instance_of Order
        expect(output.order_items.length).to eq 2
        expect(output.order_items[0].quantity).to eq 2
        expect(output.order_items[0].pack.quantity).to eq 5
        expect(output.order_items[1].quantity).to eq 2
        expect(output.order_items[1].pack.quantity).to eq 2
      end
    end

    context 'when the product_code is CF and quantity is 13' do
      it 'returns an order with order items for the packs' do
        output = store.buy('CF', 13)

        expect(output).to be_instance_of Order
        expect(output.order_items.length).to eq 2
        expect(output.order_items[0].quantity).to eq 2
        expect(output.order_items[0].pack.quantity).to eq 5
        expect(output.order_items[1].quantity).to eq 1
        expect(output.order_items[1].pack.quantity).to eq 3
      end
    end

    context 'when the product_code is not part of the list' do
      it 'raises an error' do
        expect do
          store.buy('ETH', 1)
        end.to raise_error(Store::ProductNotFound)
      end
    end
  end
end
