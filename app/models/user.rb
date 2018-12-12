class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :geo_caches, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 100 }

  validates :first_name, length: { minimum: 3, maximum: 100 }, presence: true
  validates :last_name, length: { minimum: 3, maximum: 100 }, presence: true

  before_save :avatar_url

  private

  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    self.avatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
