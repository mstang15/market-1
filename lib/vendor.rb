class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new{}
  end

  def check_stock(item)
    found_item = @inventory.keys.find do |food|
                  food == item
                end
    if found_item == nil
      0
    else
      return @inventory[found_item]
    end
  end

  def stock(item, quantity)
    if check_stock(item) == 0
      @inventory[item] = quantity
    else
      @inventory[item] += quantity
    end
  end
end
