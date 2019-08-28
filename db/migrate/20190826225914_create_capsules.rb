class CreateCapsules < ActiveRecord::Migration[5.2]
  def change
    create_table :capsules do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :season
      t.string :colors
      t.string :image

      t.timestamps
    end
  end
end
