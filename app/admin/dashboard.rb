ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel I18n.t("active_admin.superusers") do
          table_for User.superusers.order_role.each do |user|
            column(:role)
            column(:id) {|user| link_to user.id, admin_user_path(user)}
            column(:name)
            column(:email) {|user| link_to user.email, admin_user_path(user)}
          end
        end
      end

    end
  end
end
