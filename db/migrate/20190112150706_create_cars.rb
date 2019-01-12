class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
		t.belongs_to :user
		t.string :model
		t.string :transmission
		t.string :location
		t.integer :price
		
      t.timestamps
    end
  end
end
