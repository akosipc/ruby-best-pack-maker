# typed: strict
class Pack
  extend T::Sig

  sig { returns(Float) }
  attr_reader :price

  sig { returns(Integer) }
  attr_reader :quantity

  sig { params(price: Float, product_code: String, quantity: Integer, options: T::Hash[T.untyped, T.untyped]).void }
  def initialize(price:, product_code:, quantity:, **options)
    @price = T.let(price, Float)
    @quantity = T.let(quantity, Integer)
    @product_code = T.let(product_code, String)

    @options = T.let(options, T.nilable(T::Hash[T.untyped, T.untyped]))
  end

  sig { returns(String) }
  def present
    "#{@quantity} x #{@product_code} @ #{format '%.2f', @price}"
  end
end
