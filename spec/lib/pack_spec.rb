require 'spec_helper'

RSpec.describe Pack, type: :lib do
  let!(:klass) { described_class.new(price: 10, product_code: 'VS', quantity: 5) }

  describe '#present' do
    it 'returns a formatted string for the class' do
      expect(klass.present).to eq '5 x VS @ 10'
    end
  end
end
