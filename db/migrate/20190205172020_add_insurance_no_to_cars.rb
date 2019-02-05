class AddInsuranceNoToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :insurance_no, :string
  end
end
