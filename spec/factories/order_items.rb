FactoryBot.define do
  factory :order_item do
    price_in_cents { (1000..9999).to_a.sample }
    item
    order
  end
end
