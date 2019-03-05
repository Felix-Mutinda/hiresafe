class User < ApplicationRecord
	has_many :cars
	has_one_attached :avatar
	
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
    validates :mobile,:presence => true,
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
                     
	validates :fname,:presence => true
	validates :mname,:presence => true
	validates :lname,:presence => true
	validates :nat_id,:presence => true
	validates :dl_no,:presence => true
end
