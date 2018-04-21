class OrdersController < ApplicationController
  def new
    @job_listing = JobListing.friendly.find(params[:job_listing])
    @order = Order.new(job_listing: @job_listing)
    @order.order_items.build(order: @order, item: @job_listing.item, price_in_cents: @job_listing.item.price_in_cents)
    @upsell_items = Item.upsell_items
  end

  def create
    stripe_token = params[:stripe_token]
    items = Item.where(id: order_params["order_items"].keys.map(&:to_i))
    ap items

    ap order_params["order_items"].keys
  end

  private

  def order_params
    params.permit(:stripe_token, order_items: {})
  end
end
