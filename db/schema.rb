# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_31_050540) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "color_files", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_color_files_on_user_id"
  end

  create_table "memo_files", force: :cascade do |t|
    t.bigint "memo_id", null: false
    t.bigint "color_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_file_id"], name: "index_memo_files_on_color_file_id"
    t.index ["memo_id"], name: "index_memo_files_on_memo_id"
  end

  create_table "memos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tag_id", null: false
    t.bigint "color_file_id", null: false
    t.string "color_code", null: false
    t.string "comment"
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_file_id"], name: "index_memos_on_color_file_id"
    t.index ["tag_id"], name: "index_memos_on_tag_id"
    t.index ["user_id"], name: "index_memos_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firebase_id", null: false
    t.string "createdID", null: false
    t.string "nickname", null: false
  end

  add_foreign_key "color_files", "users"
  add_foreign_key "memo_files", "color_files"
  add_foreign_key "memo_files", "memos"
  add_foreign_key "memos", "color_files"
  add_foreign_key "memos", "tags"
  add_foreign_key "memos", "users"
end
