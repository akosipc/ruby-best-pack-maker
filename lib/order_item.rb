# typed: strict
class OrderItem
  extend T::Sig

  sig { returns(Pack) }
  attr_accessor :pack
  
  sig { returns(Integer) }
  attr_accessor :quantity

  sig { params( pack: Pack, quantity: Integer, options: T::Hash[T.untyped, T.untyped]).void } 
  def initialize(pack:, quantity:, **options)
    @pack = T.let(pack, Pack)
    @quantity = T.let(quantity, Integer)

    @options = T.let(options, T.nilable(T::Hash[T.untyped, T.untyped]))
  end
end
