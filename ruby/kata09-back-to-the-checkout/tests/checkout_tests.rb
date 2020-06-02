require_relative "../classes/checkout"
require_relative "../classes/item"
require_relative "../classes/deal"
require "test/unit"
 
class TestPrice < Test::Unit::TestCase

  def price(goods)
    co = CheckOut.new(RULES)
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  def test_totals
    assert_equal(  0, price(""))
    assert_equal( 50, price("A"))
    assert_equal( 80, price("AB"))
    assert_equal(115, price("CDBA"))

    assert_equal(100, price("AA"))
    assert_equal(130, price("AAA"))
    assert_equal(180, price("AAAA"))
    assert_equal(230, price("AAAAA"))
    assert_equal(260, price("AAAAAA"))

    assert_equal(160, price("AAAB"))
    assert_equal(175, price("AAABB"))
    assert_equal(190, price("AAABBD"))
    assert_equal(190, price("DABABA"))
  end

  def test_incremental
    co = CheckOut.new(RULES)
    assert_equal(  0, co.total)
    co.scan("A");  assert_equal( 50, co.total)
    co.scan("B");  assert_equal( 80, co.total)
    co.scan("A");  assert_equal(130, co.total)
    co.scan("A");  assert_equal(160, co.total)
    co.scan("B");  assert_equal(175, co.total)
  end

  # Uncomment these tests and additioanl rule to test multiple discounts
  # def test_multiple_discounts
  #   assert_equal(  20, price("EEEEE"))
  #   assert_equal(  35, price("EEEEEEEEEE"))
  #   assert_equal(  55, price("EEEEEEEEEEEEEEE"))
  #   assert_equal(  185, price("AEEEEEAEEEEEEEEEEA"))
  # end

  RULES = {
    "A" => Item.new(id: "A", price: 50, deals: Deal.new(quantity: 3, discount: 20)),
    "B" => Item.new(id: "B", price: 30, deals: Deal.new(quantity: 2, discount: 15)),
    "C" => Item.new(id: "C", price: 20),
    "D" => Item.new(id: "D", price: 15),
    # multiple discount rule:
    # "E" => Item.new(id: "E", price: 5, deals: [Deal.new(quantity: 5, discount: 5), Deal.new(quantity: 10, discount: 15)]),
  }
end