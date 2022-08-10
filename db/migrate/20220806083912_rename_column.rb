class RenameColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :color_files, :userId, :user_id
    rename_column :memos, :userId, :user_id
  end
end
