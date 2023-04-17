require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  describe '#initialize' do
    it 'exits and has attributes' do
      vendor = Vendor.new("Rocky Mountain Fresh")
      expect(vendor).to be_a(Vendor)
      expect(vendor.name).to eq("Rocky Mountain Fresh")
      expect(vendor.inventory).to eq({})
    end
  end

  describe '#check_stock and #stock' do
    before(:each) do
      @item1 = Item.new({name: 'Peach', price: "$0.75"})
      @item2 = Item.new({name: 'Tomato', price: '$0.50'})
      @vendor = Vendor.new("Rocky Mountain Fresh")
    end

    it 'can check empty inventory for item' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end

    it 'stock items to inventory' do
      @vendor.stock(@item1, 30)
      expected = {@item1 => 30}
      expect(@vendor.inventory).to eq(expected)
      @vendor.stock(@item2, 12)
      expected2 = {@item1 => 30, @item2 => 12}
      expect(@vendor.inventory).to eq(expected2)

    end

    it 'can check inventory for item and return quantity' do
      @vendor.stock(@item1, 30)
      expect(@vendor.check_stock(@item1)).to eq(30)
      @vendor.stock(@item1, 25)
      expect(@vendor.check_stock(@item1)).to eq(55)
    end
  end
end