class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name

      t.timestamps
    end
    add_index :teams, :name

    create_join_table :teams, :users do |t|
      t.index :user_id
      t.index :team_id
    end

    create_join_table :teams, :skills do |t|
      t.index :team_id
      t.index :skill_id
    end
  end
end
