class User < ApplicationRecord
  has_secure_password
    validates_presence_of :firstname, :message => " can't be blank (ชื่อไม่สามารถเว้นว่างได้)"
    validates_presence_of :lastname, :message => " can't be blank (นามสกุลไม่สามารถเว้นว่างได้)"
    validates_presence_of :phone, :message => " can't be blank (เบอร์โทรศัพท์ไม่สามารถเว้นว่างได้)"
    validates_presence_of :email, :message => "can't be blank (email ไม่สามารถเว้นว่างได้)"
    validates_presence_of :username, :message => "can't be blank (username ไม่สามารถเว้นว่างได้)"
    validates_presence_of :password, :message => "can't be blank (password ไม่สามารถเว้นว่างได้)"

    validates :username, length: {maximum: 50, minimum: 4, message: "ต้องมีความยาวอย่างน้อย 4 ตัวอักษร และไม่มากกว่า50 ตัวอักษร"}, uniqueness: { case_sensitive: false, message: "มีอยุในระบบแล้ว"  }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :phone, format: { with: /\d[0-9]\)*\z/, message: "สามารถใส่ได้แค่ตัวเลขเท่านั้น" }, length: {minimum: 10, maximum: 10, message: "ต้องมีอยุในรูปแบบ 0xxxxxxxxx และมีความยาวไม่เกิน10 ตัวเลข"}
    validates :email, length: {maximum: 255, message: "ต้องมีความยาวไม่มากกว่า255 ตัวอักษร"}, format: { with: VALID_EMAIL_REGEX , message: "ไม่สามารถลงทะเบียนได้" }, uniqueness: { case_sensitive: false , message: "มีอยุในระบบแล้ว" }
    validates :password, length: {minimum: 6 , message: "ต้องมีความยาวอย่างน้อย 6 ตัวอักษร"}
    after_save :memid

    def memid
        if !self.admin
          x1 = ((self.id+100)%1000000/100000).to_s
          x2 = ((self.id+100)%100000/10000).to_s
          x3 = ((self.id+100)%10000/1000).to_s
          x4 =((self.id+100)%1000/100).to_s
          x5 = ((self.id+100)%100/10).to_s
          x6 = ((self.id+100)%10).to_s
          memberid = "FM"+x1+x2+x3+x4+x5+x6
          self.update_column(:memberid,memberid)
        end
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
      elsif column_name == "memberid"
        where("memberid LIKE ?","%#{search}%")
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
