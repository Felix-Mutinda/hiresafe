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

ActiveRecord::Schema.define(version: 2019_03_19_103712) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cars", force: :cascade do |t|
    t.integer "user_id"
    t.string "model"
    t.string "transmission"
    t.string "location"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "insurance_no"
    t.integer "seats"
    t.string "reg_no"
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "confirmations", force: :cascade do |t|
    t.string "TransactionType"
    t.string "TransID"
    t.string "TransTime"
    t.string "TransAmount"
    t.string "BusinessShortCode"
    t.string "BillRefNumber"
    t.string "InvoiceNumber"
    t.string "OrgAccountBalance"
    t.string "ThirdPartyTransID"
    t.string "MSISDN"
    t.string "FirstName"
    t.string "MiddleName"
    t.string "LastName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hired_cars", force: :cascade do |t|
    t.integer "car_id"
    t.integer "user_id"
    t.datetime "date"
    t.integer "days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "payment"
    t.string "MpesaReceiptNumber"
    t.index ["car_id"], name: "index_hired_cars_on_car_id"
    t.index ["user_id"], name: "index_hired_cars_on_user_id"
  end

  create_table "lnmcallbacks", force: :cascade do |t|
    t.string "MerchantRequestID"
    t.string "CheckoutRequestID"
    t.string "ResultCode"
    t.string "ResultDesc"
    t.string "Amount"
    t.string "MpesaReceiptNumber"
    t.string "Balance"
    t.string "TransactionDate"
    t.string "PhoneNumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "fname"
    t.integer "nat_id"
    t.integer "balance"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lname"
    t.string "mname"
    t.integer "dl_no"
    t.integer "mobile", limit: 8
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "validations", force: :cascade do |t|
    t.string "TransactionType"
    t.string "TransID"
    t.string "TransTime"
    t.string "TransAmount"
    t.string "BusinessShortCode"
    t.string "BillRefNumber"
    t.string "InvoiceNumber"
    t.string "OrgAccountBalance"
    t.string "ThirdPartyTransID"
    t.string "MSISDN"
    t.string "FirstName"
    t.string "MiddleName"
    t.string "LastName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
