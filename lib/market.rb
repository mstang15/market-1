class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    items_array = @vendors.map do |vendor|
                    vendor.inventory.keys
                  end
    items_array.flatten.uniq.sort
  end

  def find_quantity(item)
    @vendors.inject(0) do |sum, vendor|
      if vendor.inventory.include?(item)
        vendor.inventory[item] + sum
      else
        0 + sum
      end
    end
  end

  def total_inventory
    total_inventory = Hash.new{}
    sorted_item_list.map do |item|
      total_inventory[item] = find_quantity(item)
    end
    return total_inventory
  end

  def sell(item,quantity)
    if total_inventory[item] == nil || total_inventory[item] < quantity
      false
    else
      reduce_inventory(item,quantity)
      true
    end
  end

  def reduce_inventory(item,quantity)
    vendors_with_item = @vendors.find_all do |vendor|
                        vendor.inventory.include?(item)
                      end
    vendors_with_item.map do |vendor|
      while quantity > 0
        if vendor.inventory[item] <= quantity
          vendor.inventory[item] = 0
        else
          vendor.inventory[item] -= quantity
        end
        quantity = vendor.inventory[item] - quantity
      end
      end
  end
end
