require "byebug"

class Item

  attr_accessor :id, :price, :deals

  def initialize(id:, price:, deals: nil)
    @id = id
    @price = price
    @deals = deals
  end

  def has_deals?
    !@deals.nil?
  end

end