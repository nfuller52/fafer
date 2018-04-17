class ListingsController < ApplicationController
  def net_suite
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc).net_suite
  end

  def sap
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc).sap
  end

  def oracle
    @listings = JobListing.published.order(expiration_date: :desc, id: :desc).oracle
  end
end
