ActiveAdmin.register Subject do
  menu priority: 4
  permit_params Subject::ATTRIBUTES_PARAMS

  config.batch_actions = false
  index do
    id_column
    column :image do |subject| image_sm subject end
    column :name
    column :description
    actions
  end

  show title: :name do
    attributes_table do
      row :id
      row :name
      row :image do subject.image.file.filename if subject.image? end
      row :image do image_md subject end
      row :description
      row :content do
        subject.content.html_safe if subject.content
      end
      row :created_at
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :image, as: :file, id: "subject_image", hint: image_preview(f.object)
      f.input :image_cache, as: :hidden
      f.input :description, input_html: {rows: 4}
      f.input :content, as: :ckeditor
    end
    f.actions
  end

  filter :name_cont, label: I18n.t("active_admin.name")
  filter :created_at
end
