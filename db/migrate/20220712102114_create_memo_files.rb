class CreateMemoFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :memo_files do |t|
      t.references :memo, null: false, foreign_key: true
      t.references :color_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end
