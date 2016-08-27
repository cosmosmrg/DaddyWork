class User < ApplicationRecord
  has_secure_password
    validates_presence_of :firstname, :lastname, :timeofbirthhour, :timeofbirthmin, :date, :month, :year, :birthdate, :age, :moonyear, :phone, :email, :username, :password

    validates :username, length: {maximum: 50, minimum: 4}, uniqueness: { case_sensitive: false }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :phone, format: { with: /\d[0-9]\)*\z/, message: "only allows numbers" }, length: {minimum: 10, maximum: 10}
    validates :email, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, length: {minimum: 6}
    def memid
        "FM#{((id+100)%1000000/100000).to_s+((id+100)%100000/10000).to_s+((id+100)%10000/1000).to_s+((id+100)%1000/100).to_s+((id+100)%100/10).to_s+((id+100)%10).to_s}"
    end

    def full_name
        "#{firstname} #{lastname}"
    end
    def timeofbirth
        "#{timeofbirthhour}:#{timeofbirthmin}"
    end

    def birthday
        "#{date}/#{month}/#{year}"
    end
    def self.as_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |item|
          csv << item.attributes.values_at(*column_names)
        end
      end
    end

    def self.search(search,column_name)
      if column_name == "firstname"
        where("firstname LIKE ?","%#{search}%")
      elsif column_name == "lastname"
        where("lastname LIKE ?","%#{search}%")
      elsif column_name == "date"
        where("date LIKE ?","%#{search}%")
      elsif column_name == "month"
        where("month LIKE ?","%#{search}%")
      elsif column_name == "year"
        where("year LIKE ?","%#{search}%")
      elsif column_name == "birthdate"
        where("birthdate LIKE ?","%#{search}%")
      elsif column_name == "email"
        where("email LIKE ?","%#{search}%")
      elsif column_name == "phone"
        where("phone LIKE ?","%#{search}%")
      elsif column_name == "lineid"
        where("lineid LIKE ?","%#{search}%")
      end
    end

end
