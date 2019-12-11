ActiveAdmin.register Subject do
  menu priority: 4
  permit_params Subject::ATTRIBUTES_PARAMS

  index do
    id_column
    column :identifier
    column :course
    column :description
    actions
  end

  show do
    attributes_table do
      row :id
      row :identifier
      row :course
      row :description
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :course_name, label: "Course", input_html: {disabled: true}
      f.input :identifier
      f.input :description
    end
    f.actions
  end

  sidebar "Trainees", only: :show do
    subject.subject_trainees.collect do |u|
      auto_link(u)
    end.join(content_tag("br")).html_safe
  end

  filter :identifier_cont, label: "Identifier"
  filter :course_name_cont, as: :string, label: "Course"
  filter :created_at
end
