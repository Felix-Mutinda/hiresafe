class Car < ApplicationRecord
	belongs_to :user
	has_many :hired_cars
	has_one_attached :image
end
