class AddVaccinatedTrainedToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :vaccinated, :integer
    add_column :pets, :trained, :integer
  end
end
