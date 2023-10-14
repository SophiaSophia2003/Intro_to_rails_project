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

ActiveRecord::Schema[7.0].define(version: 2023_10_15_072358) do
  create_table "authors", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_authors", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.integer "book_id"
    t.integer "author_id"
  end

  create_table "books", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "published_date"
    t.text "description"
    t.string "isbn"
    t.string "language"
    t.string "image_small_thumbnail"
    t.string "image_thumbnail"
    t.string "preview_link"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "books_categories", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "category_id"
    t.index ["book_id"], name: "index_books_categories_on_book_id"
    t.index ["category_id"], name: "index_books_categories_on_category_id"
  end

  create_table "categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publishers", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", charset: "utf8mb4", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.datetime "review_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "books", "categories"
  add_foreign_key "books_categories", "books"
  add_foreign_key "books_categories", "categories"
end
