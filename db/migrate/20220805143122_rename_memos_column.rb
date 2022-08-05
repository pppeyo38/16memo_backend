class RenameMemosColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :memos, :user_id, :userId
    rename_column :memos, :color_code, :colorCode
  end
end
