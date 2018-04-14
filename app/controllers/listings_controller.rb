class ListingsController < ApplicationController
  def index
    @listings = JobListing.published
  end

  def net_suite
    @listings = JobListing.published.net_suite
  end

  def sap
    @listings = JobListing.published.sap
  end

  def oracle
    @listings = JobListing.published.oracle
  end

  def show
    @listing = JobListing.friendly.find(params[:id])
  end
end
