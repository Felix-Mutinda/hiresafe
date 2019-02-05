class Changecolumnname < ActiveRecord::Migration[5.2]
  def change
	rename_column :users, :name, :fname
  end
end
