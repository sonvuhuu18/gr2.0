ActiveAdmin.register Feedback do
  menu priority: 6
  permit_params :status

  config.sort_order = "created_at_desc"

  scope :all
  scope :pending
  scope :in_progress
  scope :under_consideration
  scope :implemented
  scope :rejected

  #index
  index do
    id_column
    column :user
    column :title
    column :status do |feedback|
      status_tag feedback.status
    end
    column :created_at
    actions
  end

  filter :user_name_cont, label: I18n.t("active_admin.user_name")
  filter :title_cont, label: I18n.t("active_admin.title")
  filter :status, as: :select, collection: Feedback.statuses.map {|key, value| [key.humanize, value]}
  filter :created_at

  #show
  show title: :title do
    attributes_table do
      row :id
      row :user
      row :title
      row :status do status_tag feedback.status end
      row :content do feedback.content.html_safe end
      row :created_at
    end

    active_admin_comments
  end

  #new & edit
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :user, input_html: {disabled: true}
      f.input :title, input_html: {disabled: true}
      f.input :status
      f.input :content, input_html: {disabled: true}
    end
    f.actions
  end
end
