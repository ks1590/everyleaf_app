ActiveRecord::Schema.define(version: 2021_01_09_005957) do
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "detail", null: false
    t.datetime "deadline", null: false
    t.integer "priority", default: 0, null: false
    t.string "status", default: "未着手", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
