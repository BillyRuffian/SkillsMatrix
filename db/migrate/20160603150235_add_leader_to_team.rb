class AddLeaderToTeam < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :user_id, foreign_key: true
  end
end
