class CreateWants < ActiveRecord::Migration[5.2]
  def change
    create_table :wants do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.timestamps
    end
  end
end
