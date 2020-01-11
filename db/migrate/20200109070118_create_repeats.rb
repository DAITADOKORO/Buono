class CreateRepeats < ActiveRecord::Migration[5.2]
  def change
    create_table :repeats do |t|
      t.integer :restaurant_id
      t.integer :user_id


      t.timestamps
    end
  end
end
