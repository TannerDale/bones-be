class AddDefaultToPlayDateInviteStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :play_dates, :invite_status, 0
  end
end
