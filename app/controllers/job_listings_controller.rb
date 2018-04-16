class JobListingsController < ApplicationController
  before_action :set_job_listing, only: [:edit, :update, :destroy, :publish]

  def new
    @platform_name = params[:platform] if JobListing.valid_platform?(params[:platform])

    if Rails.env.development?
      stubbed_attributes = {
        company: Faker::Company.name,
        title: Faker::Job.title,
        allow_remote: [true, false].sample,
        location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
        description: Faker::Markdown.random,
        contact: Faker::Internet.email,
        platform: @platform_name
      }
      @job_listing = JobListing.new(stubbed_attributes)
    else
      @job_listing = JobListing.new(platform: @platform_name)
    end
  end

  def edit
  end

  def create
    @job_listing = JobListing.new(job_listing_params)

    if @job_listing.valid? && @job_listing.save
      redirect_to listing_path(@job_listing, preview: true), notice: "#{@job_listing.title} was created."
    else
      render :new
    end
  end

  def publish
    if @job_listing.publish!
      redirect_to listings_path, notice: "#{@job_listing.title} has been published!"
    else
      render :edit
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
    params.require(:job_listing).permit(:title, :company, :description, :platform, :allow_remote, :contact, :location)
  end
end
