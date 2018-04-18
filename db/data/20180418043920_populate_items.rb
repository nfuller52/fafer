class PopulateItems < ActiveRecord::Migration[5.2]
  def up
    items.each do |attributes|
      Item.create(attributes)
    end
  end

  def down
    Item.where(name: items.map { |item| item[:name] }).destroy_all
  end

  def items
    [
      { name: "NetSuite Job Listing", price_in_cents: 501000, feature_flag: nil },
      { name: "Oracle Job Listing", price_in_cents: 501000, feature_flag: nil },
      { name: "SAP Job Listing", price_in_cents: 501000, feature_flag: nil },
      { name: "Highlight Listing", price_in_cents: 27000, feature_flag: "is_highlighted" },
      { name: "Keep At Top of the List for 5 Days", price_in_cents: 27000, feature_flag: "is_prominent" }
    ]
  end
end
