require "byebug"

class Deal

  attr_accessor :quantity, :discount
  
  def initialize(quantity:, discount:)
    @quantity = quantity
    @discount = discount
  end

end