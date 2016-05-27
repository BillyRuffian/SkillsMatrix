class AddDescriptionToSkills < ActiveRecord::Migration[5.0]
  def change
    add_column :skills, :description, :string
  end
end
