class AddMpesaReceiptNumberToHiredCars < ActiveRecord::Migration[5.2]
  def change
    add_column :hired_cars, :MpesaReceiptNumber, :string
  end
end
