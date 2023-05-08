class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.integer :status, default: 0
      t.string :name, null: false

      t.timestamps
    end
  end
end
