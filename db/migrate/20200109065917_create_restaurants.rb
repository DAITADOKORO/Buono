class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|

      t.integer :genre_id
      t.string :shop_id
      t.string :name

      t.timestamps
    end
  end
end
