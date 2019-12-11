module InitUserSubject
  def create_user_subjects user_courses, subjects, course_id
    user_courses.to_a.product(subjects).each do |user_course_subject|
      user_course_subject.first.user_subjects.create course_id: course_id,
        user_id: user_course_subject.first.user_id,
        subject_id: user_course_subject.second.id
    end
  end
end
