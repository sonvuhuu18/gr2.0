class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
