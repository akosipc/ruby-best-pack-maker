# typed: strict
class Store
  extend T::Sig

  sig { returns(T::Array[Product]) }
  attr_reader :products

  sig { params(products: T::Array[Product], options: T::Hash[T.untyped, T.untyped]).void }
  def initialize(products:, **options)
    @products = T.let(products, T::Array[Product])

    @options = T.let(options, T.nilable(T::Hash[T.untyped, T.untyped]))
  end
end
