class CreateBlacklists < ActiveRecord::Migration[7.0]
  def change
    create_table :blacklists do |t|
      t.integer :blocked_by_id
      t.integer :blocked_id

      t.timestamps
    end
  end
end
