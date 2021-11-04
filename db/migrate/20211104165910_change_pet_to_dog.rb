class ChangePetToDog < ActiveRecord::Migration[5.2]
  def change
    rename_table :pets, :dogs
  end
end
