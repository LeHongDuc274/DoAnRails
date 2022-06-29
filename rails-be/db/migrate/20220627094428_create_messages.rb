class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
