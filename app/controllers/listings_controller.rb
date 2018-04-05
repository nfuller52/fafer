class ListingsController < ApplicationController
  def index
    @listings = JobListing.published
  end

  def show
    @listing = JobListing.friendly.find(params[:id])
  end
end
