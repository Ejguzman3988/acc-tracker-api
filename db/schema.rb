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

ActiveRecord::Schema.define(version: 2022_01_12_142213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breakdowns", force: :cascade do |t|
    t.integer "week_range"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mods", force: :cascade do |t|
    t.string "title"
    t.integer "amount"
    t.boolean "optional", default: false
    t.bigint "phase_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "breakdown_id", null: false
    t.index ["breakdown_id"], name: "index_mods_on_breakdown_id"
    t.index ["phase_id"], name: "index_mods_on_phase_id"
  end

  create_table "phases", force: :cascade do |t|
    t.string "num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "mods", "breakdowns"
  add_foreign_key "mods", "phases"
end
