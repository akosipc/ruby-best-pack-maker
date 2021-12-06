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

  sig { params(product_code: String, quantity: Integer).returns(Order) }
  def buy(product_code, quantity)
    sorted_packs = sort_packs(find_product(product_code).packs)

    Order.new(
      order_items: build_order_items(
        sorted_packs,
        best_perm(Interactions::BestValue.run!(weights: sorted_packs.collect(&:quantity), target: quantity))
      )
    )
  end

  private

  sig { params(product_code: String).returns(Product) }
  def find_product(product_code)
    product = @products.detect do |p|
      p.code == product_code
    end

    raise ProductNotFound if product.nil?

    product
  end

  sig { params(permutations: T.untyped).returns(Interactions::BestValue::Permutation) }
  def best_perm(permutations)
    permutations.select do |_key, perm|
      return perm if perm.valid?
    end
  end

  sig { params(packs: T::Array[Pack]).returns(T::Array[Pack]) }
  def sort_packs(packs)
    packs.sort_by!(&:quantity).reverse!
  end

  sig { params(sorted_packs: T::Array[Pack], perm: Interactions::BestValue::Permutation).returns(T::Array[OrderItem]) }
  def build_order_items(sorted_packs, perm)
    do_build_order_items(sorted_packs, perm, [])
  end

  sig { params(sorted_packs: T::Array[Pack], perm: Interactions::BestValue::Permutation, acc: T::Array[T.untyped]).returns(T::Array[OrderItem]) }
  def do_build_order_items(sorted_packs, perm, acc)
    acc << OrderItem.new(
      quantity: perm.dividend,
      pack: T.must(sorted_packs.detect { |p| p.quantity == perm.weight })
    )

    return acc if perm.permutations.empty?

    do_build_order_items(sorted_packs, best_perm(perm.permutations), acc)
  end
end
