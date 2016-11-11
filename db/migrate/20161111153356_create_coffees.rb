class CreateCoffees < ActiveRecord::Migration
  def change
    create_table :coffees do |t|
      t.string :name
      t.string :farm
      t.integer :pounds
      t.integer :user_id
    end
  end
end
