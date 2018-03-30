ActiveRecord::Schema.define(version: 20180330063922) do

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
