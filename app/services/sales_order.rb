class SalesOrder
  attr_accessor :job_listing
  attr_reader :order

  def initialize(job_listing)
    @job_listing = job_listing
    @order = Order.new(job_listing: job_listing, customer_email: job_listing.contact_email)
  end

  def create_order!
    @order.order_items = order_items
    @order.save
  end

  def order_items
    [OrderItem.new(order: order, item: item, price_in_cents: item.price_in_cents)]
  end

  private

  def item
    @item ||= @job_listing.item
  end
end
