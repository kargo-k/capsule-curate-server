class AddActiveColumnToCapsules < ActiveRecord::Migration[5.2]
  def change
    add_column :capsules, :active, :boolean
  end
end
