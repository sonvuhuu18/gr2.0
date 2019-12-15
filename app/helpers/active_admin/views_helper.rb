module ActiveAdmin::ViewsHelper
  def image_preview object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, id: "image_preview", class: "img-circle",
          size: Settings.admin.user_avatar_md
      else
        image_tag "", id: "image_preview", class: "img-circle",
          data: {src: Settings.admin.user_avatar_md_data_src}
      end
    else
      if object.image?
        image_tag object.image_url, id: "image_preview", class: "img-circle",
          size: Settings.admin.object_image_md
      else
        image_tag "", id: "image_preview", class: "img-circle",
          data: {src: Settings.admin.object_image_md_data_src}
      end
    end
  end

  def image_sm object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, class: "img-circle",
          size: Settings.admin.user_avatar_sm
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.admin.user_avatar_sm_data_src}
      end
    else
      if object.image?
        image_tag object.image_url, size: Settings.admin.object_image_sm
      else
        image_tag "", data: {src: Settings.admin.object_image_sm_data_src}
      end
    end
  end

  def image_md object
    if object.class.name == "User"
      if object.avatar?
        image_tag object.avatar_url, class: "img-circle",
          size: Settings.admin.user_avatar_md
      else
        image_tag "", class: "img-circle",
          data: {src: Settings.admin.user_avatar_md_data_src}
      end
    else
      if object.image?
        image_tag object.image_url, size: Settings.admin.object_image_md
      else
        image_tag "", data: {src: Settings.admin.object_image_md_data_src}
      end
    end
  end
end
