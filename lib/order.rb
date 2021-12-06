# typed: strict
class Order
  extend T::Sig

  sig { returns(T::Array[OrderItem]) }
  attr_reader :order_items

  sig { params(order_items: T::Array[OrderItem], options: T::Hash[T.untyped, T.untyped]).void }
  def initialize(order_items:, **options)
    @order_items = T.let(order_items, T::Array[OrderItem])

    @options = T.let(options, T.nilable(T::Hash[T.untyped, T.untyped]))
  end
end
