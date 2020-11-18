class User < ActiveRecord::Base

  has_secure_password
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :password, length: {minimum: 6}

  before_save {self.email = email.downcase}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else
      return false
    end
  end
  
end
