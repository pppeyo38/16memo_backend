class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firebase_id, null: false
      t.string :createdID, null: false
      t.string :nickname, null: false

      t.timestamps
    end
  end
end
