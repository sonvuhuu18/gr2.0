ActiveAdmin.register User do
  menu priority: 2

  permit_params do
    params = User::ATTRIBUTES_PARAMS if current_user.admin?
    params
  end

  scope :all
  scope :admins
  scope :trainers
  scope :trainees

  config.batch_actions = false

  config.sort_order = "order_role"

  #index
  index do
    id_column
    column :role
    column :avatar do |user| image_sm user end
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
  show do
    attributes_table do
      row :name
      row :email
      row :role
      row :gender
      row :birthday
      row :avatar do
        image_md user
      end
      row :created_at
      row :updated_at
      row :sign_in_count
      row :current_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_at
      row :last_sign_in_ip
    end

    active_admin_comments
  end

  sidebar I18n.t("active_admin.user_details"), only: :show do
    attributes_table_for user, :id, :role, :name, :email
  end

  sidebar I18n.t("active_admin.training_history"), only: :show do
    attributes_table_for user do
      row(I18n.t "active_admin.total_courses") {user.courses.count}
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
        f.input :avatar, as: :file, id: "user_avatar", hint: image_preview(f.object)
        f.input :avatar_cache, as: :hidden
        f.input :role, as: :select, collection: User::ASSIGN_ROLES, include_blank: false,
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
            f.input :role, as: :select, collection: User::ASSIGN_ROLES, include_blank: false
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
