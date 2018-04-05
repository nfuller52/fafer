class JobListingsController < ApplicationController
  before_action :set_job_listing, only: [:edit, :update, :destroy]

  def new
    @job_listing = JobListing.new
  end

  def edit
  end

  def create
    @job_listing = JobListing.new(job_listing_params)

    if @job_listing.valid? && @job_listing.save
      redirect_to listing_path(@job_listing.slug), notice: "#{@job_listing.title} was created."
    else
      render :new
    end
  end

  def update
    if @job_listing.valid? && @job_listing.update(job_listing_params)
      redirect_to listing_path(@job_listing.slug), notice: "#{@job_listing.title} was updated."
    else
      render :edit
    end
  end

  def destroy
    @job_listing.destroy
    redirect_to listings_url, notice: "#{@job_listing.title} was deleted."
  end

  private

  def set_job_listing
    @job_listing = JobListing.friendly.find(params[:id])
  end

  def job_listing_params
    params.require(:job_listing).permit(:title, :company, :publish_on, :description, :platform, :allow_remote, :contact, :location)
  end
end
