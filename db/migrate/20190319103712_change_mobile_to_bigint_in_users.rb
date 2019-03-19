class ChangeMobileToBigintInUsers < ActiveRecord::Migration[5.2]
  def change
      change_column :users, :mobile, :integer, :limit => 8
  end
end
