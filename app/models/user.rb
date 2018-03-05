class User < ActiveRecord::Base


  has_secure_password
  has_many :reviews
  validates :name, presence:true
  validates :email, presence:true,
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, length: { minimum: 6 }


  has_secure_password validations: false

  def self.authenticate_with_credentials(email, password)
     email_valid = email.downcase.strip
     user = User.find_by(email:email_valid)
       if user && user.authenticate(password)
        user
      end
  end
end
