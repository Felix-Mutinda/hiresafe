class AddEndDateToHiredCars < ActiveRecord::Migration[5.2]
  def change
    add_column :hired_cars, :end_date, :datetime
  end
end
