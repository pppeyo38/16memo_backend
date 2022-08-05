class RenameColorFilesColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :color_files, :user_id, :userId
  end
end
