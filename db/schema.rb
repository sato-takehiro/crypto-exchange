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

ActiveRecord::Schema[7.2].define(version: 2024_09_11_100723) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buying_fees", force: :cascade do |t|
    t.float "buying_fee"
    t.bigint "cryptocurrency_price_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_price_id"], name: "index_buying_fees_on_cryptocurrency_price_id"
  end

  create_table "crypto_withdrawal_fees", force: :cascade do |t|
    t.float "minimum_withdrawal", null: false
    t.float "withdrawal_fee", null: false
    t.bigint "cryptocurrency_price_id", null: false
    t.bigint "network_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_price_id"], name: "index_crypto_withdrawal_fees_on_cryptocurrency_price_id"
    t.index ["network_id"], name: "index_crypto_withdrawal_fees_on_network_id"
  end

  create_table "cryptocurrencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cryptocurrencies_on_name", unique: true
  end

  create_table "cryptocurrency_prices", force: :cascade do |t|
    t.bigint "cryptocurrency_id", null: false
    t.bigint "exchange_id", null: false
    t.float "asking_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_id"], name: "index_cryptocurrency_prices_on_cryptocurrency_id"
    t.index ["exchange_id"], name: "index_cryptocurrency_prices_on_exchange_id"
    t.check_constraint "asking_price >= 0::double precision", name: "asking_price_check"
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "limit_orders", force: :cascade do |t|
    t.float "asking_purchase_price", null: false
    t.float "asking_purchase_amount", null: false
    t.integer "purpose", null: false
    t.bigint "cryptocurrency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cryptocurrency_id"], name: "index_limit_orders_on_cryptocurrency_id"
    t.check_constraint "asking_purchase_amount > 0::double precision", name: "asking_purchase_amount_check"
    t.check_constraint "asking_purchase_price > 0::double precision", name: "asking_purchase_price_check"
  end

  create_table "networks", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "buying_fees", "cryptocurrency_prices"
  add_foreign_key "crypto_withdrawal_fees", "cryptocurrency_prices"
  add_foreign_key "crypto_withdrawal_fees", "networks"
  add_foreign_key "cryptocurrency_prices", "cryptocurrencies"
  add_foreign_key "cryptocurrency_prices", "exchanges"
  add_foreign_key "limit_orders", "cryptocurrencies"
end
