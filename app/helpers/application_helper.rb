module ApplicationHelper
  def job_post_button(controller_action: nil)
    new_job_link = JobListing.valid_platform?(controller_action) ? new_job_listing_path(platform: controller_action) : new_job_listing_path
    link_to "Post A Job For Only $301", new_job_link, class: "btn btn-success btn-lg post-button"
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: "nofollow", target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
