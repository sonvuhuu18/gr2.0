class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar
      t.date :birthday
      t.integer :gender
      t.string :role, default: "trainee"

      t.timestamps
    end
  end
end
