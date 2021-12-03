class Product
  class InvalidInventory < StandardError; end
  class PackNotFound < StandardError; end

  attr_reader :name, :code, :packs

  def initialize(name:, code:, packs: [], **options)
    @name = name
    @code = code
    @packs = packs

    @options = options
  end

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
