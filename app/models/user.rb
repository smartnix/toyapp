   
class User < ApplicationRecord
    before_save {self.email = email.downcase}
    has_many :microposts
    validates :name, presence: true, length: {maximum: 20}  
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i          
    validates :email, presence: true, length: {maximum: 30}, format: {with: VALID_EMAIL_REGEX}, 
               uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password_digest, presence: true, length: {minimum:4}
end
