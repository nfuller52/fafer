class OrdersController < ApplicationController
  before_action :set_models

  def new
    @order = Order.new(job_listing: @job_listing)
    @upsell_items = Item.upsell_items
  end

  def create
    upsell_items = Item.where(id: order_params["order_items"].keys.map(&:to_i))
    @job_listing.order = Order.new(customer_email: order_params["order"]["customer_email"])
    @order.order_items << upsell_items.map { |item| OrderItem.new(item: item, order: @order, price_in_cents: item.price_in_cents) }

    if !@job_listing.has_order? && @order.save
      respond_with(@order)
    end
  end

  private

  def set_models
    @job_listing = JobListing.friendly.find(params[:job_listing])
    @order = Order.new(job_listing: @job_listing)
    @order.order_items.build(order: @order, item: @job_listing.item, price_in_cents: @job_listing.item.price_in_cents)
  end

  def order_params
    params.permit(:stripe_token, order: [:customer_email], order_items: {})
  end
end
