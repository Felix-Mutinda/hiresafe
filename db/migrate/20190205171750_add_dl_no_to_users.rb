class AddDlNoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :dl_no, :integer
  end
end
