ActiveAdmin.register Feedback do
  menu priority: 10, if: proc{current_user.admin?}
  permit_params :status

  config.sort_order = "created_at_desc"

  scope :all
  scope :pending
  scope :in_progress
  scope :under_consideration
  scope :implemented
  scope :rejected

  actions :all, except: [:new, :create, :destroy]

  #index
  index do
    selectable_column
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

  batch_action :in_progress do |ids|
    batch_action_collection.find(ids).each do |feedback|
      feedback.update_attributes status: :in_progress
    end
    redirect_to collection_path, alert: I18n.t("active_admin.alert.feedback_in_progress")
  end

  batch_action :under_consideration do |ids|
    batch_action_collection.find(ids).each do |feedback|
      feedback.update_attributes status: :under_consideration
    end
    redirect_to collection_path, alert: I18n.t("active_admin.alert.feedback_under_consideration")
  end

  batch_action :implemented do |ids|
    batch_action_collection.find(ids).each do |feedback|
      feedback.update_attributes status: :implemented
    end
    redirect_to collection_path, alert: I18n.t("active_admin.alert.feedback_implemented")
  end

  batch_action :rejected do |ids|
    batch_action_collection.find(ids).each do |feedback|
      feedback.update_attributes status: :rejected
    end
    redirect_to collection_path, alert: I18n.t("active_admin.alert.feedback_rejected")
  end

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
      f.input :content, as: :ckeditor, input_html: {disabled: true}
    end
    f.actions
  end
end
