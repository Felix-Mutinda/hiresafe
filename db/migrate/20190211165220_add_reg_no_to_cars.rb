class AddRegNoToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :reg_no, :string
  end
end
