class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable, :validatable
  devise :database_authenticatable, :timeoutable, :registerable,
         :recoverable, :rememberable, :trackable
end
