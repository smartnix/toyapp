   
class User < ApplicationRecord
    attr_accessor :remember_token
    before_save {self.email = email.downcase}
    has_many :microposts
    validates :name, presence: true, length: {maximum: 20}  
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i          
    validates :email, presence: true, length: {maximum: 30}, format: {with: VALID_EMAIL_REGEX}, 
               uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password_digest, presence: true, length: {minimum:4}

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
                                                        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
end
