class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.references :color_file, null: false, foreign_key: true
      t.string :color_code, null: false
      t.string :comment
      t.text :url

      t.timestamps
    end
  end
end
