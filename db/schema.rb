# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_231_105_050_046) do
  create_table 'stocks', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'teams', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'transactions', force: :cascade do |t|
    t.decimal 'amount'
    t.integer 'source_wallet_id'
    t.integer 'target_wallet_id'
    t.integer 'operation'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['source_wallet_id'], name: 'index_transactions_on_source_wallet_id'
    t.index ['target_wallet_id'], name: 'index_transactions_on_target_wallet_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'auth_token'
  end

  create_table 'wallets', force: :cascade do |t|
    t.string 'user_type', null: false
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[user_type user_id], name: 'index_wallets_on_user'
  end

  add_foreign_key 'transactions', 'wallets', column: 'source_wallet_id'
  add_foreign_key 'transactions', 'wallets', column: 'target_wallet_id'
end
