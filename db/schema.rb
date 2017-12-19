# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171219195018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bible_verses", force: :cascade do |t|
    t.bigint "biblebook_id"
    t.integer "chapter_nr"
    t.integer "verse_nr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["biblebook_id"], name: "index_bible_verses_on_biblebook_id"
  end

  create_table "biblebooks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "booksequence"
    t.string "testament"
    t.string "abbreviation"
  end

  create_table "chapters", id: :serial, force: :cascade do |t|
    t.integer "chapter_number"
    t.string "description"
    t.integer "biblebook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nrofverses"
    t.index ["biblebook_id"], name: "index_chapters_on_biblebook_id"
  end

  create_table "pericope_as_ranges", force: :cascade do |t|
    t.string "name"
    t.bigint "starting_verse_id"
    t.bigint "ending_verse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ending_verse_id"], name: "index_pericope_as_ranges_on_ending_verse_id"
    t.index ["starting_verse_id"], name: "index_pericope_as_ranges_on_starting_verse_id"
  end

  create_table "pericopes", id: :serial, force: :cascade do |t|
    t.integer "studynote_id"
    t.integer "starting_verse"
    t.integer "ending_verse"
    t.integer "biblebook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "ending_chapter_nr"
    t.integer "starting_chapter_nr"
    t.string "biblebook_name"
    t.integer "sequence"
    t.integer "starting_verse_id"
    t.integer "ending_verse_id"
    t.index ["biblebook_id"], name: "index_pericopes_on_biblebook_id"
    t.index ["studynote_id"], name: "index_pericopes_on_studynote_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "studynote_id"
    t.index ["studynote_id"], name: "index_roles_on_studynote_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "studynotes", id: :serial, force: :cascade do |t|
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "author_id"
    t.index ["author_id"], name: "index_studynotes_on_author_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bible_verses", "biblebooks"
  add_foreign_key "chapters", "biblebooks"
  add_foreign_key "pericope_as_ranges", "bible_verses", column: "ending_verse_id"
  add_foreign_key "pericope_as_ranges", "bible_verses", column: "starting_verse_id"
  add_foreign_key "pericopes", "biblebooks"
  add_foreign_key "pericopes", "studynotes"
  add_foreign_key "roles", "studynotes"
  add_foreign_key "roles", "users"
  add_foreign_key "studynotes", "users", column: "author_id"
end
