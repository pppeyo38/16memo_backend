class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firebase_id, :string, null: false
    add_column :users, :created_id, :string, null: false
    add_column :users, :nickname, :string, null: false
  end
end
