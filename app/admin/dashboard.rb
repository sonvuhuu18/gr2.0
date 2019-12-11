ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "SuperUser" do
          table_for User.superusers.order_role.each do |user|
            column(:role)
            column(:id) {|user| link_to user.id, admin_user_path(user)}
            column(:name)
            column(:email) {|user| link_to user.email, admin_user_path(user)}
          end
        end
      end

    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
