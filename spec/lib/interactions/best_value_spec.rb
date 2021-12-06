# typed: false
require 'spec_helper'

RSpec.describe Interactions::BestValue, type: :interaction do
  describe '#run!' do
    it 'creates a permutation matrix for a collection and target to be attained - first' do
      result = described_class.run!(weights: [8, 5, 2], target: 17)

      expect(result[8].dividend).to eq 2
      expect(result[8].remainder).to eq 1
      expect(result[8].permutations.count).to eq 2
      expect(result[8]).not_to be_valid

      expect(result[5].dividend).to eq 3
      expect(result[5].remainder).to eq 2
      expect(result[5].permutations.count).to eq 1
      expect(result[5]).to be_valid

      expect(result[2].dividend).to eq 8
      expect(result[2].remainder).to eq 1
      expect(result[2].permutations.count).to eq 0
      expect(result[2]).not_to be_valid
    end

    it 'creates a permutation matrix for a collection and target to be attained - second' do
      result = described_class.run!(weights: [9, 5, 3], target: 18)

      expect(result[9].dividend).to eq 2
      expect(result[9].remainder).to eq 0
      expect(result[9].permutations.count).to eq 0
      expect(result[9]).to be_valid

      expect(result[5].dividend).to eq 3
      expect(result[5].remainder).to eq 3
      expect(result[5].permutations.count).to eq 1
      expect(result[5]).to be_valid

      expect(result[3].dividend).to eq 6
      expect(result[3].remainder).to eq 0
      expect(result[3].permutations.count).to eq 0
      expect(result[3]).to be_valid
    end

    it 'creates a permutation matrix for a collection and target to be attained - third' do
      result = described_class.run!(weights: [5, 3], target: 13)

      expect(result[5].dividend).to eq 2
      expect(result[5].remainder).to eq 3
      expect(result[5].permutations.count).to eq 1
      expect(result[5]).to be_valid

      expect(result[3].dividend).to eq 4
      expect(result[3].remainder).to eq 1
      expect(result[3].permutations.count).to eq 0
      expect(result[3]).not_to be_valid
    end
  end
end

RSpec.describe Interactions::BestValue::Permutation, type: :klass do
  describe '#valid?' do
    it 'returns true if the permutation is the last one' do
      permutation = described_class.new(weight: 100, dividend: 5, remainder: 0, permutations: {})

      expect(permutation).to be_valid
    end

    it 'returns true if there permutations and they are valid' do
      permutation = described_class.new(weight: 100, dividend: 5, remainder: 0, permutations: {})
      permutation2 = described_class.new(weight: 100, dividend: 5, remainder: 0, permutations: { a: permutation })

      expect(permutation2).to be_valid
    end

    it 'returns false when there is a remainder in the permutation' do
      permutation = described_class.new(weight: 100, dividend: 5, remainder: 1, permutations: {})

      expect(permutation).not_to be_valid
    end
  end
end
