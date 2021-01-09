class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :detail, null: false
      t.datetime :deadline, null: false
      t.integer :priority, default: 0, null: false
      t.string :status, default: "未着手", null: false
      t.timestamps
    end
  end
end
