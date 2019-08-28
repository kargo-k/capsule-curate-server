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

ActiveRecord::Schema.define(version: 2019_08_28_181145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "capsules", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "season"
    t.string "colors"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "capsules_items", id: false, force: :cascade do |t|
    t.bigint "capsule_id", null: false
    t.bigint "item_id", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "shop_link"
    t.string "description"
    t.string "color"
    t.string "fabric"
    t.string "category"
    t.string "price"
    t.string "image"
    t.boolean "personal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category2"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "bio"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "location"
    t.string "profile_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
