class PublicationsController < ApplicationController
  def create
    @job_listing = JobListing.friendly.find(params[:id])

    if @job_listing.publish!
      redirect_to job_listings_path, notice: "#{@job_listing.title} has been published!"
    else
      render template: "job_listings/edit"
    end
  end
end
