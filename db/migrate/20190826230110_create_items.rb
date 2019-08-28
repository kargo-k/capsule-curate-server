class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :brand
      t.string :shop_link
      t.string :description
      t.string :color
      t.string :fabric
      t.string :type
      t.string :price
      t.string :image
      t.boolean :personal

      t.timestamps
    end
  end
end
