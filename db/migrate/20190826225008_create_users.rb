class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :bio
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :location
      t.string :profile_image

      t.timestamps
    end
  end
end
