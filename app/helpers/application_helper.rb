module ApplicationHelper
  def full_title page_title = ""
    base_title = "Training System"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error || :failed then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def feedback_label status
    case status
    when "pending"
      "default"
    when "in_progress"
      "info"
    when "under_consideration"
      "warning"
    when "implemented"
      "success"
    when "rejected"
      "danger"
    end
  end
end
