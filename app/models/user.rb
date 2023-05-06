class User < ApplicationRecord
  has_secure_password
  before_save :format_data

  validates_presence_of :first_name, :last_name, :email, :mobile_number, :password, :birthdate, :gender, :gender_interest, :country, :region, :city

  
  validates :email, uniqueness: true

  validates :first_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, length: { in: 1..20 }

  validates :last_name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, length: { in: 1..20 }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, length: { in: 6..20 }, allow_nil: true
  
  validates :mobile_number, format: { with: /\A(09)\d{9}\z/ }

  enum role: { user: 0, admin: 1 }
  enum gender: { man: 0, woman: 1, nonbinary: 3 }
  enum gender_interest: { men: 0, women: 1, nonbinary: 3 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def format_data
    self.email = self.email.downcase
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
    self.city = self.city.capitalize
    self.region = self.region.capitalize
    self.country = self.country.capitalize
  end
end
