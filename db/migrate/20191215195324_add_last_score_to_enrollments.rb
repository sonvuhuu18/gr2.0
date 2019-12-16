class AddLastScoreToEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_column :enrollments, :last_score, :integer, default: 0
  end
end
