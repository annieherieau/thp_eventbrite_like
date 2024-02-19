class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|

      t.text :description
      t.string :first_name
      t.string :last_name

      t.string :email
      t.string :encrypted_password
      t.string :password_hash
      t.string :remember_digest

      t.timestamps
    end
  end
end
