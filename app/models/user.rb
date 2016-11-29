#Need the digest library for hash calcuation.
require 'digest'
class User < ActiveRecord::Base
  #Creat a virtual attribute "password"
  #A virtual attribute is an attribute not corresponding to a column in DB.
  attr_accessor :password
  attr_accessible :email, :name ,:password, :password_confirmation,:encrypted_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,:presence =>true,
                  :length => { :maximum => 50}

  validates :email,:presence => true,
                   :format => { :with => email_regex},
                   :uniqueness => { :case_sensitive => false }

# Add vaildations to the "password" attribute.
# Also automatically creat the virtual attribute "password_confimation".

  validates :password, :presence => true,
                       :confirmation => true,# creat "password_confimation"
		       :length => { :within => 6..40}

  before_save :encrypt_password

  def has_password?(submitted_password)
       encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
      user = find_by_email(email)
      return nil if user.nil?
      return user if user.has_password?(submitted_password)
      return nil
  end

  private

  def encrypt_password
      self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
     string # a temporary implementation, will be changed later.
  end


  def encrypt(string)
      Digest::SHA2.hexdigest(string)
  end

 

end
