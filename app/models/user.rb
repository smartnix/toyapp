class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    has_many :microposts
    validates :name, presence: true, length: {maximum: 20}            
    validates :email, presence: true, length: {maximum: 30}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
end
