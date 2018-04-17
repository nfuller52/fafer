class ListingsController < ApplicationController
  def net_suite
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc)
  end

  def sap
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc)
  end

  def oracle
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc)
  end
end
