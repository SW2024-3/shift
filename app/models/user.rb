class User < ApplicationRecord
    has_many :chats 
    
    has_secure_password
    
    validates :uname,:name, presence: true
    validates :money,presence: true,numericality: { only_integer: true }
end
