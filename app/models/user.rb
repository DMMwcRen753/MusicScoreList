class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :scores
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :mylists, dependent: :destroy
  has_many :score_lists, dependent: :destroy
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  
  def active_for_authentication?
    super && (status == false)
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲ ス ト"
    end
  end
  
  validates :name, presence: true
  validates :status, inclusion: { in: [true, false] }
end
