class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :shop_id
      t.string :name
      t.text :image
      t.string :tag_list
      t.timestamps
    end
  end
end
