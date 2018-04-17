class PlatformsController < ApplicationController
  def show
    @platform = Platform.friendly.find(params[:id])
    @listings = JobListing.published.where(platform: @platform)
  end
end
