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

ActiveRecord::Schema.define(version: 20140218074042) do

  create_table "animals", force: true do |t|
    t.string   "name"
    t.string   "breed"
    t.string   "gender"
    t.string   "age"
    t.text     "habits"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "considerations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fosters", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "animal_id"
    t.integer  "consideration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["animal_id"], name: "index_line_items_on_animal_id"
  add_index "line_items", ["consideration_id"], name: "index_line_items_on_consideration_id"

  create_table "pet_selectors", force: true do |t|
    t.integer  "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pet_selectors", ["animal_id"], name: "index_pet_selectors_on_animal_id"

end
