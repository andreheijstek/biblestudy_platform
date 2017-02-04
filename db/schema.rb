# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170114115435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "biblebooks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "booksequence"
    t.string   "testament"
    t.string   "abbreviation"
  end

  create_table "chapters", force: :cascade do |t|
    t.integer  "chapter_number"
    t.string   "description"
    t.integer  "biblebook_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "nrofverses"
  end

  add_index "chapters", ["biblebook_id"], name: "index_chapters_on_biblebook_id", using: :btree

  create_table "pericopes", force: :cascade do |t|
    t.integer  "studynote_id"
    t.integer  "starting_verse"
    t.integer  "ending_verse"
    t.integer  "biblebook_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
    t.integer  "ending_chapter_nr"
    t.integer  "starting_chapter_nr"
    t.string   "biblebook_name"
    t.integer  "sequence"
  end

  add_index "pericopes", ["biblebook_id"], name: "index_pericopes_on_biblebook_id", using: :btree
  add_index "pericopes", ["studynote_id"], name: "index_pericopes_on_studynote_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "role"
    t.integer  "studynote_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "roles", ["studynote_id"], name: "index_roles_on_studynote_id", using: :btree
  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "studynotes", force: :cascade do |t|
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "author_id"
  end

  add_index "studynotes", ["author_id"], name: "index_studynotes_on_author_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "chapters", "biblebooks"
  add_foreign_key "pericopes", "biblebooks"
  add_foreign_key "pericopes", "studynotes"
  add_foreign_key "roles", "studynotes"
  add_foreign_key "roles", "users"
  add_foreign_key "studynotes", "users", column: "author_id"
end
