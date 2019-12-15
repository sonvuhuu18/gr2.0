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

  def trainee_image_preview object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, id: "image_preview", class: "img-responsive img-circle",
          size: Settings.admin.user_avatar_md
      else
        image_tag "", id: "image_preview", class: "img-circle",
          data: {src: Settings.admin.user_avatar_md_data_src}
      end
    else
      if object.image?
        image_tag object.image_url, id: "image_preview", class: "img-responsive img-circle",
          size: Settings.admin.object_image_md
      else
        image_tag "", id: "image_preview", class: "img-circle",
          data: {src: Settings.admin.object_image_md_data_src}
      end
    end
  end

  def trainee_image_sm object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, class: "img-circle",
          size: Settings.trainee.user_avatar_sm
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.trainee.user_avatar_sm_data_src}
      end
    else
      if object.image?
        image_tag object.image_url, class: "img-circle",
          size: Settings.trainee.object_image_sm
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.trainee.object_image_sm_data_src}
      end
    end
  end

  def trainee_image_md object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, class: "img-circle",
          size: Settings.trainee.user_avatar_md
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.trainee.user_avatar_md_data_src}
      end
    else
      if object.image?
        image_tag object.image_url, class: "img-circle",
          size: Settings.trainee.object_image_md
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.trainee.object_image_md_data_src}
      end
    end
  end

  def trainee_image_lg object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, class: "img-circle",
          size: Settings.trainee.user_avatar_lg
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.trainee.user_avatar_lg_data_src}
      end
    else
      if object.image?
        image_tag object.image_url, class: "img-circle",
          size: Settings.trainee.object_image_lg
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.trainee.object_image_lg_data_src}
      end
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

  def course_label status
    case status
    when "init"
      "label label-info"
    when "progress"
      "label label-warning"
    when "finish"
      "label label-danger"
    end
  end

  def user_course_label status
    case status
    when "init"
      "color-green"
    when "progress"
      "color-blue"
    when "finish"
      "color-red"
    end
  end

  def user_subject_label status
    case status
    when "init"
      "bg-green"
    when "progress"
      "bg-blue"
    when "finish"
      "bg-red"
    end
  end
end
