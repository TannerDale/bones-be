class AddStatusToPlayDate < ActiveRecord::Migration[5.2]
  def change
    add_column :play_dates, :invite_status, :integer
  end
end
