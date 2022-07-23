class RemoveColumnToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :screen_name, :string
  end
end
