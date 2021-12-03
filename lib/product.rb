# typed: strict
class Product
  extend T::Sig

  class InvalidInventory < StandardError; end
  class PackNotFound < StandardError; end

  sig { returns(String) }
  attr_reader :name

  sig { returns(String) }
  attr_reader :code

  sig { returns(T::Array[Pack]) }
  attr_reader :packs

  sig { params(name: String, code: String, packs: T::Array[Pack], options: T::Hash[T.untyped, T.untyped]).void }
  def initialize(name:, code:, packs: [], **options)
    @name = T.let(name, String)
    @code = T.let(code, String)
    @packs = T.let(packs, T::Array[Pack])

    @options = T.let(options, T.nilable(T::Hash[T.untyped, T.untyped]))
  end

  sig { params(quantity: Integer).returns(Pack) }
  def suggested_price_for(quantity)
    raise InvalidInventory, 'Inventory is not an array' unless packs.is_a? Array
    raise InvalidInventory, 'Inventory is currently empty' if packs.length.zero?

    selected_pack = @packs.select do |pack|
      pack.quantity == quantity
    end.first

    raise PackNotFound, "Inputted quantity does not have pack. Inputted was #{quantity}" if selected_pack.nil?

    selected_pack
  end
end
