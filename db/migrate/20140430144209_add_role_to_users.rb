class AddRoleToUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string
  end

  def down
    remove_column :role, :string
  end
end
