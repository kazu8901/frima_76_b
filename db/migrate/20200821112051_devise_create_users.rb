# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :family_name, null: false
      t.string :first_name, null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :email, null: false, default: ""
      t.date   :birthday, null: false
      t.string :image
      t.text   :introdaction
      t.string :nickname, null: false
      t.string :password, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    # add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
