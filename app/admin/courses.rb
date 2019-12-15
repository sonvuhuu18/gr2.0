ActiveAdmin.register Course do
  menu priority: 3
  permit_params Course::ATTRIBUTES_PARAMS

  scope :all
  scope :init_courses
  scope :progress_courses
  scope :finish_courses

  config.sort_order = "status_asc"

  index do
    id_column
    column :code
    column :name
    column :status do |course|
      status_tag course.status
    end
    column :start_date
    column :end_date
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :code
      row :name
      row :image do course.image.file.filename end
      row :image do
        image_tag course.image_url, class: "img-responsive",
          size: Settings.admin.course_show_image if course.image?
      end
      row :description
      row :content do
        course.content.html_safe
      end
      row :status do |course|
        status_tag course.status
      end
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
    end

    panel I18n.t("active_admin.subjects") do
      table_for course.subjects.each do |s|
        column :name do |s|
          link_to s.name, admin_subject_path(s)
        end
        column :description
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    tabs do
      tab "Course" do
        f.inputs "Course Basic" do
          f.input :code
          f.input :name
          f.input :image, as: :file, id: "course_image", hint: image_preview(f.object)
          f.input :image_cache, as: :hidden
          f.input :description, input_html: {rows: 4}
          f.input :content, as: :ckeditor
          f.input :start_date, as: :datepicker
          f.input :end_date, as: :datepicker
        end
      end
      if !f.object.new_record?
        tab "Assign Users" do
          f.inputs "Users" do
            f.input :users, label: "Superusers", as: :check_boxes, collection: User.superusers
            f.input :users, label: "Trainee", as: :check_boxes,
              collection: User.trainee_available_for_course(f.object.id)
          end
        end
      end
      tab "Add Subjects" do
        f.inputs do
          f.has_many :course_subjects, allow_destroy: true, heading: "Select Subjects" do |s|
            s.input :subject, collection: Subject.all.map{|sub| [sub.name, sub.id]}
          end
        end
      end
    end
    f.actions
  end

  action_item :start_course, only: :show do
    link_to "Start", start_course_admin_course_path(course),
      class: "addition_action_items", method: :put if course.init?
  end

  action_item :finish_course, only: :show do
    link_to "Finish", finish_course_admin_course_path(course),
      class: "addition_action_items", method: :put if course.progress?
  end

  member_action :start_course, method: :put do
    course = Course.find params[:id]
    course.update_course_and_enrollments :progress
    redirect_to admin_course_path(course)
  end

  member_action :finish_course, method: :put do
    course = Course.find params[:id]
    course.update_course_and_enrollments :finish
    redirect_to admin_course_path(course)
  end

  filter :code_cont, label: I18n.t("active_admin.code")
  filter :name_cont, label: I18n.t("active_admin.name")
  filter :status, as: :select, collection: Course.statuses
  filter :start_date
  filter :end_date
  filter :created_at

  sidebar "Course Stats", :only => :show do
    attributes_table_for course do
      row("Total Subjects")  {course.subjects.count}
      row("Superusers") {course.course_superusers.count}
      row("Trainees") {course.course_trainees.count}
    end
  end

  sidebar "Superusers", only: :show do
    course.course_superusers.collect do |u|
      auto_link(u)
    end.join(content_tag("br")).html_safe
  end

  sidebar "Trainees", only: :show do
    course.course_trainees.collect do |u|
      auto_link(u)
    end.join(content_tag("br")).html_safe
  end

  sidebar "Subjects", only: :show do
    course.course_subjects.collect do |cs|
      link_to cs.subject.name, admin_subject_path(cs.subject)
    end.join(content_tag("br")).html_safe
  end
end
