class JobListingsController < ApplicationController
  before_action :set_job_listing, only: [:show, :edit, :update, :destroy, :publish]
  before_action :protect_from_malevolence, only: [:edit, :update, :destroy]

  def index
    @listings = JobListing.published
  end

  def show
    if !@job_listing.published? && params[:preview] != "true"
      raise ActiveRecord::RecordNotFound
    else
      @preview_mode = !@job_listing.published? && params[:preview] == "true" ? true : false
    end
  end

  def new
    @platform = Platform.friendly.find(params[:platform]) if params[:platform].present?
    @job_listing = JobListing.new(platform: @platform)
  end

  def edit
    raise ActiveRecord::RecordNotFound if @job_listing.published?
  end

  def create
    @job_listing = JobListing.new(job_listing_params)

    if @job_listing.valid? && @job_listing.save
      @job_listing.create_order!

      redirect_to listing_path(@job_listing, preview: true), notice: "#{@job_listing.title} was created."
    else
      render :new
    end
  end

  def update
    raise ActiveRecord::RecordNotFound unless @job_listing.can_be_updated?

    if @job_listing.update(job_listing_params)
      redirect_to listing_path(@job_listing, preview: true), notice: "#{@job_listing.title} was updated."
    else
      render :edit
    end
  end

  def destroy
    @job_listing.destroy
    redirect_to job_listings_url, notice: "#{@job_listing.title} was deleted."
  end

  private

  def set_job_listing
    @job_listing = JobListing.friendly.find(params[:id])
  end

  def job_listing_params
    params.require(:job_listing).permit(:title, :company, :description, :platform_id, :allow_remote, :contact_name, :contact_email, :location)
  end

  def protect_from_malevolence
    # TODO The idea is to add unique key to the record which is valid for 5 minutes. After that time, 404 is raised
    rails ActiveRecord::RecordNotFound unless true
  end
end
