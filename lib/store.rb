# typed: strict
class Store
  class ProductNotFound < StandardError; end

  extend T::Sig

  sig { returns(T::Array[Product]) }
  attr_reader :products

  sig { params(products: T::Array[Product], options: T::Hash[T.untyped, T.untyped]).void }
  def initialize(products:, **options)
    @products = T.let(products, T::Array[Product])

    @options = T.let(options, T.nilable(T::Hash[T.untyped, T.untyped]))
  end

  sig { params(product_code: String, quantity: Integer).void }
  def buy(product_code, quantity)
    product = @products.detect do |product|
      product.code == product_code
    end

    raise ProductNotFound if product.nil?
  end
end
