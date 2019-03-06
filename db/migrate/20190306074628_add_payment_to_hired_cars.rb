class AddPaymentToHiredCars < ActiveRecord::Migration[5.2]
  def change
    add_column :hired_cars, :payment, :string
  end
end
