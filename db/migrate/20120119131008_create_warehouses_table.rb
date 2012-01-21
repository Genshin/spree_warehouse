class CreateWarehousesTable < ActiveRecord::Migration
 def change
    create_table :warehouses do |t|
      t.string :name , :null => false
      t.string :code
      t.text :location
      t.text :details
 
      t.timestamps
    end
  end
end
