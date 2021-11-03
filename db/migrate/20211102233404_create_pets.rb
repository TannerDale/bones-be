class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :size
      t.string :breed
      t.integer :age
      t.string :sex
      t.boolean :trained
      t.boolean :vaccinated
      t.string :description

      t.timestamps
    end
  end
end
