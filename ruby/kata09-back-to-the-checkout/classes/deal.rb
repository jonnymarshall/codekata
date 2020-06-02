class Deal
  attr_reader :quantity, :discount

  def initialize(quantity:, discount:)
    @quantity = quantity
    @discount = discount
  end
end
