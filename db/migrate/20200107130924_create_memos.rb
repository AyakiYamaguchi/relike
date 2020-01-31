class CreateMemos < ActiveRecord::Migration[6.0]
  def change
    create_table :memos do |t|
      t.integer :remind_list_id , null: false
      t.text :content , null: false

      t.timestamps
    end
  end
end
