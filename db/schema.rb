ActiveRecord::Schema.define(version: 2021_11_25_132704) do
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "status"
    t.integer "duration"
    t.bigint "user_id", null: false
    t.bigint "plug_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plug_id"], name: "index_bookings_on_plug_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "plugs", force: :cascade do |t|
    t.integer "plug_type"
    t.string "location"
    t.text "description"
    t.integer "fixed_cost_per_15_min"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "availability"
    t.index ["user_id"], name: "index_plugs_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "contents"
    t.integer "review_type"
    t.bigint "booking_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "gender"
    t.integer "plug_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "plugs"
  add_foreign_key "bookings", "users"
  add_foreign_key "plugs", "users"
  add_foreign_key "reviews", "bookings"
end
