class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :mobile_number, null: false
      t.date :birthdate, null: false
      t.integer :gender, null: false
      t.string :country, null: false
      t.string :region, null: false
      t.string :city, null: false
      t.string :school
      t.string :bio, null: false
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
