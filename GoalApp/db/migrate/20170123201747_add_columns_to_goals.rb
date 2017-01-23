class AddColumnsToGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :title, :string, null: false
    add_column :goals, :details, :text, null: false
    add_column :goals, :private, :boolean, default: false
    add_column :goals, :completed, :boolean, default: false

    add_index :goals, :user_id
  end
end
