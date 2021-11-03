class ChangeValueToEnums < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :vaccinated, :integer
    remove_column :pets, :trained, :integer
  end
end
