class ListingsController < ApplicationController
  def index
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc)
  end

  def net_suite
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc).net_suite
  end

  def sap
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc).sap
  end

  def oracle
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc).oracle
  end

  def show
    @listing = JobListing.friendly.find(params[:id])

    @preview_mode = params[:preview] == "true" && !@listing.published? ? true : false
  end
end
