# Kata09: Back to the Checkout

## Supermarket checkout that calculates the total price of a number of items, including multiprice deals.

### Compatibility

Tested for compatibility with RUBY VERSION: 2.7.1


### item.rb

Items are initialized with an id, a price, and n number of Deals (optional):

```
Item.new(id: "id", price: price, deals = nil)
```

Examples:

```
Item.new(id: "A", price: 50)
Item.new(id: "A", price: 50, deals: Deal.new(quantity: 3, discount: 20))
```

If there are multiple deals, they can also be supplied as an array:

```
Item.new(id: "A", price: 50, deals: [deal1, deal2])
```

### deal.rb

Deals are initialized with a quantity (amount required to qualify for discount) and a discount.
It can be assigned to one of more Items.

```
Deal.new(quantity: 3, discount: 20)
```

### checkout.rb

Checkout is initialized with a single argument - a set of pricing rules containing all items.

```
Cheackout.new(RULES)
```

Methods:
.scan("item_id") - Adds item to basket
.total - Returns total cost for all items minus any discounts that apply

```
checkout = Cheackout.new(RULES)
checkout.scan("A")
checkout.total
=> 50
```

### RULES

RULES is a constant (hash) comprised of individual rules.

```
RULES = {
  # rule 1,
  # rule 2,
  # ...
}
```

Each rule is an instance of item. The ID as key must match the item's id. Example:

```
RULES = {
  "A" => Item.new(id: "A", price: 50)
}
```