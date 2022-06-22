class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login_id
      t.string :display_name
      t.string :password_digest
      t.string :login_token
      t.string :access_token
      t.integer :status
      t.integer :role

      t.timestamps
    end
  end
end
