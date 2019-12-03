# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|

      ## LINEアカウント情報
      t.string :line_uid , null: false , unique: true
      t.string :line_access_token , null: false , unique: true
      t.string :line_refresh_token, null: false , unique: true
      t.string :line_username
      
      ## Twitterアカウント情報
      t.string :twitter_uid 
      t.string :twitter_access_token
      t.string :twitter_access_secret

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip


      t.timestamps null: false
    end

  end
end
