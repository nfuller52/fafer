module ApplicationHelper
  def job_post_button
    platform_slug = @platform.present? ? @platform.slug : nil
    link_to "Post A Job For Only $301", new_job_listing_path(platform: platform_slug), class: "btn btn-success btn-lg post-button"
  end

  def wizard_button(text, step)
    content_tag :button, text, class: "btn btn-lg btn-#{step ? "primary" : "secondary"}", style: "flex: 1"
  end

  def preview_or_edit?
    return false if @job_listing.new_record?
    current_page?(listing_path(@job_listing)) || current_page?(edit_job_listing_path(@job_listing))
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
