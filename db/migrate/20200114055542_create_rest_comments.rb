class CreateRestComments < ActiveRecord::Migration[5.2]
  def change
    create_table :rest_comments do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.text :comment
      t.decimal :score, precision: 5, scale: 3
      t.timestamps
    end
  end
end
