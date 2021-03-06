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

ActiveRecord::Schema.define(:version => 20160212213438) do

  create_table "resource_as", :force => true do |t|
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "parent_id"
    t.integer  "master_id"
    t.integer  "leader_id"
    t.string   "explicit_attr"
    t.string   "implicit_attr"
    t.string   "custom_attr"
    t.string   "nested_accessor"
    t.string   "dynamic_accessor"
    t.string   "private_accessor"
    t.string   "aliased_accessor"
    t.string   "from_accessor"
    t.string   "to_accessor"
    t.string   "compound_accessor"
    t.string   "nested_compound_accessor"
    t.string   "unexposed_attr"
  end

  create_table "resource_bs", :force => true do |t|
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "other_id"
    t.integer  "extra_id"
    t.string   "explicit_attr"
    t.string   "implicit_attr"
    t.string   "custom_attr"
    t.string   "nested_accessor"
    t.string   "dynamic_accessor"
    t.string   "private_accessor"
    t.string   "aliased_accessor"
    t.string   "from_accessor"
    t.string   "to_accessor"
    t.string   "compound_accessor"
    t.string   "nested_compound_accessor"
    t.string   "unexposed_attr"
  end

end
