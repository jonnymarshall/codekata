require "byebug"

class CheckOut

  def initialize(pricing_rules)
    @items = []
    @pricing_rules = pricing_rules
    @cost = 0
    @discounts = 0
  end

  def scan(item)
    @items << @pricing_rules[item]
  end

  def total
    clear_basket
    item_tally =  @items.map { |item| item[:id] }.tally
    
    item_tally.each do | item_code, quantity |
      item = @pricing_rules[item_code]
      calculate_cost(item, quantity)
      calculate_discounts(item, quantity)
    end

    @cost - @discounts
  end

  private

  def clear_basket
    @cost, @discounts = 0, 0
  end

  def calculate_cost(item, quantity)
    @cost += item[:price] * quantity
  end

  def calculate_discounts(item, quantity)
    @discounts += item[:discount] * (quantity / item[:deal]) if item.has_key?(:deal) && quantity >= item[:deal]
  end

end