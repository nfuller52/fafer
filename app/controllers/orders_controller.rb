class OrdersController < ApplicationController
  def new
    @job_listing = JobListing.friendly.find(params[:job_listing])
    @order = Order.new(job_listing: @job_listing)
    @order.order_items.build(order: @order, item: @job_listing.item, price_in_cents: @job_listing.item.price_in_cents)
  end

  def create
  end
end
