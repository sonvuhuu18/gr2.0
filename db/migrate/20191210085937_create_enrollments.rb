class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :enrollments, [:user_id, :course_id], unique: true
  end
end
