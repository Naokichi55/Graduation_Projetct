module ApplicationHelper
  def page_title(title = '')
		base_title = 'My Rake'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def page_heading(title = '')
    if title.present?
      "#{title}"
    end 
  end
end
