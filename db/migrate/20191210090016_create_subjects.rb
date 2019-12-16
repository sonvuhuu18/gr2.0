class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :image
      t.text :description
      t.text :content

      t.timestamps
    end
  end
end
