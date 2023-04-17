class Market 
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_item_list
    item_names = @vendors.flat_map do |vendor| 
      vendor.inventory.keys 
    end.uniq
    item_names.sort_by do |item| 
      item.name 
    end
  end

  def total_inventory
    inventory_hash = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if inventory_hash[item].nil?
          item_hash = {}
          item_hash[:quantity] = quantity
          item_hash[:vendors] = [vendor]
          inventory_hash[item] = item_hash
        else
          inventory_hash[item][:quantity] += quantity
          inventory_hash[item][:vendors] << vendor
        end
      end
    end
    inventory_hash

  end

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, item_info|
      if item_info[:vendors].length > 1 && item_info[:quantity] > 50
        overstocked_items << item
      end
    end
    overstocked_items
  end
end