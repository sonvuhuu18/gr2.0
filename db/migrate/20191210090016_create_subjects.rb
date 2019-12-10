class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :identifier
      t.text :description
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
