class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.integer :wins
      t.integer :losses
      t.integer :draws

      t.timestamps
    end
  end
end
