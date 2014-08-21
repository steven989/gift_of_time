class User < ActiveRecord::Base
  authenticates_with_sorcery!
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, uniqueness: true
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  has_many :gifts, dependent: :destroy
  has_many :authentications, dependent: :destroy

  accepts_nested_attributes_for :authentications

  def display_name
    self.first_name.blank? || self.first_name.nil? ? self.email : self.first_name+" "+self.last_name
  end

  def admin?
    self.role == 'admin'
  end 

end
