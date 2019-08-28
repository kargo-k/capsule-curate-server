class CreateJoinTableCapsulesItems < ActiveRecord::Migration[5.2]
  def change
    create_join_table :capsules, :items do |t|
      # t.index [:capsule_id, :item_id]
      # t.index [:item_id, :capsule_id]
    end
  end
end
