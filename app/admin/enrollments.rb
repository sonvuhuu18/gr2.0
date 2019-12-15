ActiveAdmin.register Enrollment do
  permit_params :status

  actions :index, :show

  #index
  scope "All", :all_trainee_courses, default: true
  scope :init_enrollments
  scope :progress_enrollments
  scope :finish_enrollments

  config.sort_order = "status_asc"

  index do
    column resource_selection_toggle_cell, class: "col-selectable", sortable: false do |resource|
      if can? :batch_action, resource
        resource_selection_cell resource
      end
    end
    id_column
    column :user
    column :course
    column :status do |enrollment| status_tag enrollment.status end
    actions
  end

  filter :user_name_cont, label: I18n.t("active_admin.user_name")
  filter :status, as: :select, collection: Enrollment.statuses

  batch_action :start do |ids|
    batch_action_collection.find(ids).each do |enrollment|
      enrollment.update_attributes status: :progress
    end
    redirect_to collection_path, alert: I18n.t("active_admin.alert.enrollment_start")
  end

  batch_action :finish do |ids|
    batch_action_collection.find(ids).each do |enrollment|
      enrollment.update_attributes status: :finish
    end
    redirect_to collection_path, alert: I18n.t("active_admin.alert.enrollment_finish")
  end

  #show
  show do
    attributes_table do
      row :id
      row :course
      row :user
      row :status do status_tag enrollment.status end
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

end
