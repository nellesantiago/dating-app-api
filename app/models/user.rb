class User < ApplicationRecord
  has_secure_password
  has_many_attached :image

  has_many :interests, dependent: :destroy

  before_save :validate_image

  has_many :messages, dependent: :destroy

  has_many :likes_received, foreign_key: :to_user_id, class_name: "Match", dependent: :destroy
  has_many :likers, through: :likes_received, source: :from

  has_many :likes_given, foreign_key: :from_user_id, class_name: "Match", dependent: :destroy
  has_many :likes, through: :likes_given, source: :to

  has_many :blocks_received, foreign_key: :blocked_id, class_name: "Blacklist", dependent: :destroy
  has_many :blockers, through: :blocks_received, source: :blocked_by

  has_many :blocks_given, foreign_key: :blocked_by_id, class_name: "Blacklist", dependent: :destroy
  has_many :blocks, through: :blocks_given, source: :blocked

  validates_presence_of :first_name, :last_name, :email, :mobile_number, :birthdate, :gender, :country, :region, :city, :bio

  validates :email, uniqueness: true

  before_save :format_data

  validate :validate_age

  validates :first_name, format: { with: /\A[A-Za-z]+(?: [A-Za-z]+)*\z/, message: "only allows letters" }, length: { in: 1..20 }

  validates :last_name, format: { with: /\A[A-Za-z]+(?: [A-Za-z]+)*\z/, message: "only allows letters" }, length: { in: 1..20 }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, length: { in: 6..20 }, allow_nil: true

  validates :mobile_number, format: { with: /\A(09)\d{9}\z/ }

  enum role: { user: 0, admin: 1 }
  enum gender: { man: 0, woman: 1, nonbinary: 2 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def format_data
    self.email = self.email.downcase
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
    self.city = self.city.titleize
    self.region = self.region.titleize
    self.country = self.country.titleize
    self.school = self.school.titleize if self.school
  end

  def validate_age
    if birthdate.present? && birthdate > 18.years.ago.to_date
      errors.add(:birthdate, "You should be over 18 years old.")
    end
  end

  def matches
    likes_received.where(status: "matched").pluck(:from_user_id) + likes_given.where(status: "matched").pluck(:to_user_id)
  end

  def validate_image
    if image.empty?
      errors.add(:image, "must include at least one photo")
    elsif image.length > 5
      errors.add(:image, "cannot exceed 5 photos")
    end
  end

  def gender_interests
    interests.pluck(:gender)
  end

  def blocked_by_user_ids
    blockers.pluck(:id)
  end

  def blocked_users
    blocks.pluck(:id)
  end

  def matched_user_ids
    likes_received.pluck(:from_user_id) + likes_given.pluck(:to_user_id)
  end

  def liked_user_ids
    likes_given.pluck(:to_user_id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
