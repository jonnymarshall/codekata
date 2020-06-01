require "byebug"

class CheckOut

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = []
    @cost = 0
    @discounts = 0
  end

  def scan(item)
    @items << @pricing_rules[item]
  end

  def total
    clear_basket
    item_tally =  @items.map { |item| item.id }.tally
    
    item_tally.each do | item_code, quantity |
      item = @pricing_rules[item_code]
      calculate_cost(item, quantity)
      calculate_discounts(item, quantity) if item.has_deals?
    end

    @cost - @discounts
  end

  private

  def clear_basket
    @cost, @discounts = 0, 0
  end

  def calculate_cost(item, quantity)
    @cost += item.price * quantity
  end

  def calculate_discounts(item, quantity)
    deals_descending_quantity = item.deals.sort_by { |deal| deal.quantity }.reverse

    deals_descending_quantity.each do | deal |
      if quantity >= deal.quantity
        @discounts += deal.discount * (quantity / deal.quantity) if quantity >= deal.quantity
        quantity -= deal.quantity
      end
    end

  end
end