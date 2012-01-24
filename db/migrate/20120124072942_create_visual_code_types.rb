class CreateVisualCodeTypes < ActiveRecord::Migration
  def change
    create_table :visual_code_types do |t|
      t.string :name
      t.string :handler

      t.timestamps
    end
  end
end
