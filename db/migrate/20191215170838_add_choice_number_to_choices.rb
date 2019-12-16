class AddChoiceNumberToChoices < ActiveRecord::Migration[5.2]
  def change
    add_column :choices, :choice_number, :integer
  end
end
