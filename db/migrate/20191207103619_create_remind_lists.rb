class CreateRemindLists < ActiveRecord::Migration[5.2]
  def change
    create_table :remind_lists do |t|
      t.integer  :user_id , null: false
      t.string   :tweet_acount_id , null: false
      t.string   :tweet_id , null: false
      t.date     :next_remind_at
      t.integer  :remind_count , default: 0, null: false

      t.timestamps
    end
  end
end
