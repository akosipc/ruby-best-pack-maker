# typed: strict
module Interactions
  class BestValue
    extend T::Sig

    class Permutation
      extend T::Sig

      sig { returns(Integer) }
      attr_reader :dividend

      sig { returns(Integer) }
      attr_reader :remainder

      sig { returns(T::Hash[T.untyped, Permutation]) }
      attr_reader :permutations

      sig { params(weight: Integer, dividend: Integer, remainder: Integer, permutations: T::Hash[T.untyped, Permutation]).void }
      def initialize(weight:, dividend:, remainder:, permutations:)
        @weight = T.let(weight, Integer)
        @dividend = T.let(dividend, Integer)
        @remainder = T.let(remainder, Integer)
        @permutations = T.let(permutations, T::Hash[T.untyped, Permutation])
      end

      sig { returns(T.any(FalseClass, TrueClass)) }
      def valid?
        if @permutations.any?
          @permutations.each { |_key, object| return false unless object.valid? }.any?
        else
          @remainder == 0 && @permutations.length == 0
        end
      end
    end

    sig { params(weights: T::Array[Integer], target: Integer).returns(T::Hash[T.untyped, T.untyped]) }
    def self.run!(weights:, target:)
      {}.tap do |hash|
        weights.each do |weight|
          div, mod = target.divmod(weight)

          hash[weight] = Permutation.new(
            weight: weight,
            dividend: div,
            remainder: mod,
            permutations: mod.zero? ? {} : run!(weights: permutations(weights, weight), target: target - (weight * div))
          )
        end
      end
    end

    sig { params(weights: T::Array[Integer], target: Integer).returns(T::Array[Integer]) }
    def self.permutations(weights, target)
      weights.reject do |weight|
        weight >= target
      end
    end
  end
end
