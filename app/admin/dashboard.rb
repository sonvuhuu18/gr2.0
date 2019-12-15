ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel I18n.t("active_admin.superusers") do
          table_for User.superusers.order_role.each do |user|
            column(:name)
            column(:email) {|user| link_to user.email, admin_user_path(user)}
            column(:role)
          end
        end
      end

      column do
        panel I18n.t("active_admin.active_courses") do
          table_for Course.active_courses.order("status asc") do
            column(:name) {|course| link_to course.name, admin_course_path(course)}
            column(:image) {|course| image_sm course}
            column(:status) {|course| status_tag course.status}
            column(:start_date)
            column(:end_date)
          end
        end
      end
    end

    columns do
      column do
        panel I18n.t("active_admin.trainees_of_active_courses_chart") do
          render "active_trainee_courses_chart"
        end
      end
      column do
        panel I18n.t("active_admin.active_courses_chart") do
          render "active_courses_chart"
        end
      end
    end
  end # content
end
