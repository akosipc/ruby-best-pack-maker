class Pack
  attr_reader :price, :quantity

  def initialize(price:, product_code:, quantity:, **options)
    @price = price
    @quantity = quantity
    @product_code = product_code

    @options = options
  end

  def present
    "#{@quantity} x #{@product_code} @ #{@price}"
  end
end
