class CreatePlayDates < ActiveRecord::Migration[5.2]
  def change
    create_table :play_dates do |t|
      t.references :creator_dog, foreign_key: { to_table: 'dogs' }
      t.references :invited_dog, foreign_key: { to_table: 'dogs' }
      t.string :location_id
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
