class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable, :registerable, :validatable
  devise :database_authenticatable, :timeoutable,
         :recoverable, :rememberable, :trackable
end
