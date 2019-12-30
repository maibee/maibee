|currency            |
|--------------------|
|string  name        |
|decimal last_rate   |
|string  codename    |

  create_table "orders", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.decimal "amount"
    t.decimal "price"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "number"
    t.string "state"
    t.index ["currency_id"], name: "index_orders_on_currency_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.decimal "amount"
    t.string "target"
    t.string "num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["currency_id"], name: "index_transfers_on_currency_id"
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "unread", default: 0
    t.boolean "status", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "recognition"
    t.decimal "amount"
    t.bigint "user_id", null: false
    t.bigint "currency_id", null: false
    t.index ["currency_id"], name: "index_wallets_on_currency_id"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "orders", "currencies"
  add_foreign_key "orders", "users"
  add_foreign_key "records", "users"
  add_foreign_key "transfers", "currencies"
  add_foreign_key "transfers", "users"
  add_foreign_key "wallets", "currencies"
  add_foreign_key "wallets", "users"
end
