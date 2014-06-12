class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_many :gifts

end
