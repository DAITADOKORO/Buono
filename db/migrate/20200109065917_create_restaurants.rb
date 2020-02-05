class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :shop_id
      t.string :name
      t.text :image
      t.string :prefecture
      t.string :area
      t.string :tag_list
      t.float :latitude, precision: 8, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.timestamps
    end
  end
end
