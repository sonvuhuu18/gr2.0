ActiveAdmin.register User do
  menu priority: 2

  config.sort_order = "id_asc"

  permit_params do
    params = User::ATTRIBUTES_PARAMS if current_user.admin?
    params
  end

  scope :all
  scope :admins
  scope :trainers
  scope :trainees

  #index
  index do
    id_column
    column :role
    column :name
    column :email
    column :gender
    column :birthday
    column :created_at
    actions
  end

  filter :role, as: :select, collection: User::ROLES
  filter :name_cont, label: I18n.t("active_admin.name")
  filter :email_cont, label: I18n.t("active_admin.email")
  filter :gender, as: :select, collection: User.genders
  filter :birthday
  filter :created_at

  #show
  sidebar I18n.t("active_admin.user_details"), :only => :show do
    attributes_table_for user, :id, :role, :name, :email, :gender, :birthday,
      :created_at, :updated_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at
  end

  sidebar I18n.t("active_admin.training_history"), :only => :show do
    attributes_table_for user do
      row(I18n.t "active_admin.total_courses") {user.courses.count}
      row(I18n.t "active_admin.total_subjects") {user.subjects.count}
    end
  end

  #new & edit
  form do |f|
    f.semantic_errors *f.object.errors.keys
    if f.object.new_record?
      f.inputs do
        f.input :name
        f.input :email
        f.input :gender
        f.input :birthday, as: :datepicker
        f.input :role, as: :select, collection: User::ROLES, include_blank: false,
          selected: "trainee"
        f.input :password
        f.input :password_confirmation
      end
    else
      tabs do
        tab I18n.t("active_admin.basic") do
          f.inputs I18n.t("active_admin.basic_details") do
            f.input :name
            f.input :email
            f.input :gender
            f.input :birthday, as: :datepicker
          end
        end
        tab I18n.t("active_admin.advanced") do
          f.inputs I18n.t("active_admin.advanced_details") do
            f.input :role, as: :select, collection: User::ROLES, include_blank: false
            f.input :password
            f.input :password_confirmation
          end
        end
      end
    end
    f.actions
  end

  controller do
    def update_resource object, attributes
      update_method = attributes.first[:password].present? ?
        :update_attributes : :update_without_password
      object.send update_method, *attributes
    end
  end
end
