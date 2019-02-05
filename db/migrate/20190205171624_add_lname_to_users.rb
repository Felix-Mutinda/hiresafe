class AddLnameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lname, :string
    add_column :users, :add_mname_to_users, :string
    add_column :users, :mname, :string
  end
end
