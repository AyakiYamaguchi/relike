class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :line_access_token,:string, null: true
    change_column :users, :line_refresh_token,:string, null: true
  end

  def down
    change_column :users, :line_access_token,:string, null: false
    change_column :users, :line_refresh_token,:string, null: false
  end
end
