class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable, :validatable, :rememberable,
  # :database_authenticatable, :timeoutable, :registerable,
  #  :recoverable,
  devise :trackable, :database_authenticatable, :timeoutable, :registerable,
   :recoverable

  # :ldap_authenticatable, 


end
