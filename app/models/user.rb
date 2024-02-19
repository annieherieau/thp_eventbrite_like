require 'bcrypt'
class User < ApplicationRecord
  attr_accessor :input_pwd
  #Table 1-N
  has_many :admin_events, foreign_key: 'admin_event_id', class_name: 'Event'

  #table N-N through
  has_many :attendances
  has_many :events, through: :attendances

  # Bcrypt
  # users.password_hash in the database is a :string
  include BCrypt
  PASSWORD_REQUIREMENTS = /\A
  (?=.{8,}) # Minimum 8 charactere de longueur
  (?=.*\d) # Contient au mini 1 chiffre
  (?=.*[a-z]) # Au mini un lowecase
  (?=.*[A-Z]) # Au mini un uppercase
  (?=.[[:^alnum:]]) # Au mini 1 symbole
  /x

  # validation
  validates :first_name, :last_name, presence: true
  validates :email, presence: true , uniqueness: true, confirmation: true
  validate :is_password_valid?
  validates :password,  presence: true,  confirmation: true

  # callbacks
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def password
    @password ||= Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    @password == password
  end

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end

  private
  def is_password_valid?
    return if input_pwd.blank? || input_pwd.length >= 8 && input_pwd.match(/\d/) && input_pwd.match(/[a-z]/) && input_pwd.match(/[A-Z]/) && input_pwd.match(/[^a-zA-Z\d]/)
    errors.add :password, 'Password must be at least 8 characters long and include at least one digit, one lowercase letter, one uppercase letter, and one special character.'
  end

end
