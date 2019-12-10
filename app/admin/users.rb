ActiveAdmin.register User do
  menu :priority => 2
  config.sort_order = "id_asc"
  permit_params do
    params = User::ATTRIBUTES_PARAMS if current_user.admin?
    params
  end

  controller do
    def update_resource object, attributes
      update_method = attributes.first[:password].present? ?
        :update_attributes : :update_without_password
      object.send update_method, *attributes
    end
  end

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
        tab "Basic" do
          f.inputs "Basic Details" do
            f.input :name
            f.input :email
            f.input :gender
            f.input :birthday, as: :datepicker
          end
        end
        tab "Advanced" do
          f.inputs "Advanced Details" do
            f.input :role, as: :select, collection: User::ROLES, include_blank: false
            f.input :password
            f.input :password_confirmation
          end
        end
      end
    end
    f.actions
  end

  filter :role, as: :select, collection: User::ROLES
  filter :name
  filter :email
  filter :gender, as: :select, collection: User.genders
  filter :birthday
  filter :created_at

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

  sidebar "User Details", :only => :show do
    attributes_table_for user, :id, :role, :name, :email, :gender, :birthday,
      :created_at, :updated_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at
  end

  sidebar "Training History", :only => :show do
    attributes_table_for user do
      row("Total Courses") { user.courses.count }
      row("Total Subjects") { user.subjects.count }
    end
  end
end
