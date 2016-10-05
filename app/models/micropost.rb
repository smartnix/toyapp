class Micropost < ApplicationRecord
    belongs_to :user    
    validates :content, length: {maximum:70}, presence: true
end
