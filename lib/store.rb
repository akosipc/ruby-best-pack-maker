class Store
  attr_reader :products

  def initialize(products: **options)
    @products = products

    @options = options
  end
end
