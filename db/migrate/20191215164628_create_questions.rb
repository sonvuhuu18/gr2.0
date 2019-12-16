class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :subject, foreign_key: true
      t.string :content
      t.integer :answer

      t.timestamps
    end
  end
end
