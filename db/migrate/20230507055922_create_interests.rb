class CreateInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :interests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :gender, null: false

      t.timestamps
    end
  end
end
