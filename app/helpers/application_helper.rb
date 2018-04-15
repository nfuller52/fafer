module ApplicationHelper
  def job_post_button(controller_action: nil)
    new_job_link = JobListing.valid_platform?(controller_action) ? new_job_listing_path(platform: controller_action) : new_job_listing_path
    link_to "Post A Job For Only $301", new_job_link, class: "btn btn-success btn-lg post-button"
  end
end
