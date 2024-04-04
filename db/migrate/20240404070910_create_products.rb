class CreateProducts < ActiveRecord::Migration[5.0]
  def change
     create_table :products do |t|
       t.string :name
       t.text :description
       t.timestamps
     end
     add_index :products, :name, unique: true
   end
end
