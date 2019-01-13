class CreateHiredCars < ActiveRecord::Migration[5.2]
  def change
    create_table :hired_cars do |t|
      t.references :car, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :date
      t.integer :days

      t.timestamps
    end
  end
end
