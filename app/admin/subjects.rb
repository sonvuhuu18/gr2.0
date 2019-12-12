ActiveAdmin.register Subject do
  menu priority: 4
  permit_params Subject::ATTRIBUTES_PARAMS

  index do
    id_column
    column :name
    column :description
    actions
  end

  show title: :name do
    attributes_table do
      row :id
      row :name
      row :description
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :description, input_html: {rows: 4}
    end
    f.actions
  end

  filter :name_cont, label: I18n.t("active_admin.name")
  filter :created_at
end
