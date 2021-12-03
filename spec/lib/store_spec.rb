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

  describe '#order' do
    it 'does something' do
    end
  end
end
