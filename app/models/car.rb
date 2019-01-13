class Car < ApplicationRecord
	belongs_to :user
	has_one :hired_car
end
