class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_many :gifts
  has_many :authentications, dependent: :destroy

  accepts_nested_attributes_for :authentications

end
