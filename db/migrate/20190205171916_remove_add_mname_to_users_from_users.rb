class RemoveAddMnameToUsersFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :add_mname_to_users, :string
  end
end
