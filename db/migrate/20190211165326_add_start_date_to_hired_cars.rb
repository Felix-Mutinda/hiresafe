class AddStartDateToHiredCars < ActiveRecord::Migration[5.2]
  def change
    add_column :hired_cars, :start_date, :datetime
  end
end
