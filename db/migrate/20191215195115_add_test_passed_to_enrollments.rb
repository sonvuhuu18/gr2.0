class AddTestPassedToEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_column :enrollments, :test_passed, :boolean, default: false
  end
end
