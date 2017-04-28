require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :password
  validates :username, presence: true, uniqueness: true, length: { in: 3...15 }
  validates_length_of :password, in: 6...30, on: create
  validates :password, confirmation: true
  has_many :articles
  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
	self.salt = Digest::SHA256.hexdigest("#{username}#{Time.now} as the salt")
	self.encrypted_password = Digest::SHA256.hexdigest("#{salt} and #{password}")
  end
  
  def clear_password
	self.password = nil
  end

  def match_password(login_password="")
	encrypted_password == Digest::SHA256.hexdigest("#{salt} and #{login_password}")
  end

  def self.authenticate(username="", login_password="")
	user = User.find_by(username: username)
	if user && user.match_password(login_password)
	  return user
	else
	  return false
	end
  end
end
