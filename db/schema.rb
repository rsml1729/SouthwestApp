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

ActiveRecord::Schema.define(version: 20170206002255) do

  create_table "pnrs", id: false, force: :cascade do |t|
    t.string   "rcrd_loc"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "a_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rcrd_loc"], name: "index_pnrs_on_rcrd_loc", unique: true
  end

  create_table "segments", force: :cascade do |t|
    t.string   "rcrd_loc"
    t.string   "od"
    t.string   "flt_num"
    t.datetime "flt_time"
    t.datetime "checkin_time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "pnr_id"
    t.index ["pnr_id"], name: "index_segments_on_pnr_id"
  end

  create_table "whitelists", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "member"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
