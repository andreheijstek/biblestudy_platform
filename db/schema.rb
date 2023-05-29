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

ActiveRecord::Schema[7.0].define(version: 2023_05_28_203146) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bible_verses", force: :cascade do |t|
    t.integer "chapter"
    t.integer "verse"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "biblebook_categories", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "biblebook_id"
    t.index ["biblebook_id"], name: "index_biblebook_categories_on_biblebook_id"
  end

  create_table "biblebooks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "booksequence"
    t.string "testament"
    t.string "abbreviation"
    t.bigint "bible_verse_id"
    t.bigint "biblebook_category_id"
    t.index ["biblebook_category_id"],
            name: "index_biblebooks_on_biblebook_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.text "name"
    t.bigint "biblebook_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["biblebook_id"], name: "index_categories_on_biblebook_id"
  end

  create_table "chapters", id: :serial, force: :cascade do |t|
    t.integer "chapter_number"
    t.string "description"
    t.integer "biblebook_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "nrofverses"
    t.index ["biblebook_id"], name: "index_chapters_on_biblebook_id"
  end

  create_table "pericope_as_ranges", force: :cascade do |t|
    t.string "name"
    t.bigint "starting_verse_id"
    t.bigint "ending_verse_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["ending_verse_id"],
            name: "index_pericope_as_ranges_on_ending_verse_id"
    t.index ["starting_verse_id"],
            name: "index_pericope_as_ranges_on_starting_verse_id"
  end

  create_table "pericopes", id: :serial, force: :cascade do |t|
    t.integer "studynote_id"
    t.integer "biblebook_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name"
    t.string "biblebook_name"
    t.integer "sequence"
    t.bigint "start_verse_id"
    t.bigint "end_verse_id"
    t.index ["biblebook_id"], name: "index_pericopes_on_biblebook_id"
    t.index ["end_verse_id"], name: "index_pericopes_on_end_verse_id"
    t.index ["start_verse_id"], name: "index_pericopes_on_start_verse_id"
    t.index ["studynote_id"], name: "index_pericopes_on_studynote_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "role"
    t.integer "studynote_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["studynote_id"], name: "index_roles_on_studynote_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "st_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studynote_tags", force: :cascade do |t|
    t.bigint "studynote_id"
    t.bigint "st_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["st_tag_id"], name: "index_studynote_tags_on_st_tag_id"
    t.index ["studynote_id"], name: "index_studynote_tags_on_studynote_id"
  end

  create_table "studynotes", id: :serial, force: :cascade do |t|
    t.text "note"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "title"
    t.integer "author_id"
    t.index ["author_id"], name: "index_studynotes_on_author_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type],
            name: "taggings_idx",
            unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index %w[taggable_id taggable_type context],
            name: "taggings_taggable_context_idx"
    t.index %w[taggable_id taggable_type tagger_id context],
            name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index %w[taggable_type taggable_id],
            name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index %w[tagger_id tagger_type],
            name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index %w[tagger_type tagger_id],
            name: "index_taggings_on_tagger_type_and_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "admin", default: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"],
            name: "index_users_on_reset_password_token",
            unique: true
  end

  create_table "verses", id: :serial, force: :cascade do |t|
    t.integer "verse_number"
    t.string "verse_text"
    t.integer "chapter_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["chapter_id"], name: "index_verses_on_chapter_id"
  end

  add_foreign_key "biblebook_categories", "biblebooks"
  add_foreign_key "categories", "biblebooks"
  add_foreign_key "chapters", "biblebooks"
  add_foreign_key "pericopes", "bible_verses", column: "end_verse_id"
  add_foreign_key "pericopes", "bible_verses", column: "start_verse_id"
  add_foreign_key "pericopes", "biblebooks"
  add_foreign_key "pericopes", "studynotes"
  add_foreign_key "roles", "studynotes"
  add_foreign_key "roles", "users"
  add_foreign_key "studynote_tags", "st_tags"
  add_foreign_key "studynote_tags", "studynotes"
  add_foreign_key "studynotes", "users", column: "author_id"
  add_foreign_key "taggings", "tags"
  add_foreign_key "verses", "chapters"
end
