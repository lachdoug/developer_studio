class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable, :validatable, :rememberable
  devise :database_authenticatable, :timeoutable, :registerable,
         :recoverable, :trackable
end
