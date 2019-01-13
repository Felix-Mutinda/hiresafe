class User < ApplicationRecord
	has_many :cars
	has_many :hired_cars
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :nat_id, presence: true,
				length: { minimum: 8, maximum: 8 }
	validates :name, presence: true
end
