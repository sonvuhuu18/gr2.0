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

  def image_preview object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, id: "image_preview", class: "img-responsive", size: "150x150"
      else
        image_tag "", id: "image_preview", data: {src: "holder.js/150x150?theme=gray&text=Avatar"}
      end
    else
      if object.image?
        image_tag object.image_url, id: "image_preview", class: "img-responsive", size: "150x150"
      else
        image_tag "", id: "image_preview", data: {src: "holder.js/150x150?theme=gray&text=Image"}
      end
    end
  end

end
