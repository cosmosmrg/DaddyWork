class User < ApplicationRecord
  has_secure_password
    validates_presence_of :firstname, :lastname, :timeofbirthhour, :timeofbirthmin, :date, :month, :year, :birthdate, :age, :moonyear, :phone, :lineid, :email, :username, :password

    validates :username, length: {maximum: 50, minimum: 4}, uniqueness: { case_sensitive: false }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :phone, format: { with: /\d[0-9]\)*\z/, message: "only allows numbers" }, length: {minimum: 10, maximum: 10}
    validates :email, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, length: {minimum: 6}

end
