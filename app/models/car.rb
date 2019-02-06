class Car < ApplicationRecord
	belongs_to :user
	has_many :hired_cars
	
	has_one_attached :image1
	has_one_attached :image2
end
