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

ActiveRecord::Schema.define(version: 2021_11_08_175426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.integer "size"
    t.string "breed"
    t.integer "age"
    t.string "sex"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "vaccinated"
    t.integer "trained"
  end

  create_table "play_dates", force: :cascade do |t|
    t.bigint "creator_dog_id"
    t.bigint "invited_dog_id"
    t.string "location_id"
    t.date "date"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invite_status", default: 0
    t.index ["creator_dog_id"], name: "index_play_dates_on_creator_dog_id"
    t.index ["invited_dog_id"], name: "index_play_dates_on_invited_dog_id"
  end

  add_foreign_key "play_dates", "dogs", column: "creator_dog_id"
  add_foreign_key "play_dates", "dogs", column: "invited_dog_id"
end
