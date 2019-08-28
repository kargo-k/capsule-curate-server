class AddColumnCategory2ToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category2, :string
  end
end
