module ApplicationHelper

  # Returns the full title on a per-page basis
  def full_title(page_title)
    base_title = "IdeaSpark"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def flash_class(level)
    case level
      when :notice        then 'alert alert-info'
      when :warning       then 'alert alert-warning'
      when :success       then 'alert alert-success'
      when :error, :alert then 'alert alert-danger'
    end
  end
end
