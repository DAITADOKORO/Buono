class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|

      t.integer :genre_id
      t.text :comment
      t.string :image_id
      t.text :item_text
      t.string :item_name

      t.timestamps
    end
  end
end
