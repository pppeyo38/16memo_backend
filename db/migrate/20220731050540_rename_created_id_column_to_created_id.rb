class RenameCreatedIdColumnToCreatedId < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :created_id, :createdID
  end
end
