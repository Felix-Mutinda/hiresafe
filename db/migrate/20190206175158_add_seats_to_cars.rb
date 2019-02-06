class AddSeatsToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :seats, :integer
  end
end
