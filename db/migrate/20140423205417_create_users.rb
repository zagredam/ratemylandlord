class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string  :email
      t.string :uid
      t.string :access_token
      t.string :expires
      t.boolean :permissions

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end