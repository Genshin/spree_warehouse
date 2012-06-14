class CreateSpreeSuppliersTable < ActiveRecord::Migration
  def change 
  	create_table :spree_suppliers do |t|
      t.string :company, :null => false 
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zipcode
      t.string :phone_number
      t.string :mobile_number
      t.string :email
      t.string :website
      t.references :state
      t.references :country
      t.timestamps
    end
  end
end
