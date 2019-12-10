class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :status, default: 0
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
