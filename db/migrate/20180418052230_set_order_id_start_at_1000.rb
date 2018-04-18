class SetOrderIdStartAt1000 < ActiveRecord::Migration[5.2]
  def change
    execute("SELECT setval('orders_id_seq', 1000)")
  end
end
