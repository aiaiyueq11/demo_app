class User < ActiveRecord::Base
  attr_accessible :email, :name

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  vaildates :email,:presence => true,
                   :format => { :with => email_regex}
                   :uniqueness => { :case_sensitive => false }

  vaildates :name,:presence =>true,
                  :length => { :maximum => 50}

end
