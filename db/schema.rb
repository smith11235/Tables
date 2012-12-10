# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121210202935) do

  create_table "cells", :force => true do |t|
    t.integer  "record_id"
    t.integer  "field_id"
    t.string   "string"
    t.datetime "datetime"
    t.integer  "int"
    t.float    "float"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cells", ["field_id"], :name => "index_cells_on_field_id"
  add_index "cells", ["record_id"], :name => "index_cells_on_record_id"

  create_table "data_sets", :force => true do |t|
    t.string   "name"
    t.string   "parameters"
    t.string   "checksum"
    t.string   "source"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fields", :force => true do |t|
    t.integer  "data_set_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "fields", ["data_set_id"], :name => "index_fields_on_data_set_id"

  create_table "joins", :force => true do |t|
    t.string   "name"
    t.integer  "left_key_id"
    t.integer  "right_key_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "joins", ["left_key_id"], :name => "index_joins_on_left_key_id"
  add_index "joins", ["right_key_id"], :name => "index_joins_on_right_key_id"

  create_table "key_fields", :force => true do |t|
    t.integer  "key_id"
    t.integer  "field_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "key_fields", ["field_id"], :name => "index_key_fields_on_field_id"
  add_index "key_fields", ["key_id"], :name => "index_key_fields_on_key_id"

  create_table "key_records", :force => true do |t|
    t.integer  "key_id"
    t.integer  "record_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "key_records", ["key_id"], :name => "index_key_records_on_key_id"
  add_index "key_records", ["record_id"], :name => "index_key_records_on_record_id"

  create_table "keys", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "keyable_id"
    t.string   "keyable_type"
  end

  create_table "records", :force => true do |t|
    t.integer  "data_set_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "records", ["data_set_id"], :name => "index_records_on_data_set_id"

end
