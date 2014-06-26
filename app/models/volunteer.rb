class Volunteer < ActiveRecord::Base
    validates :title, presence: true
    validates :description, presence: true
    validates :organization, presence: true
    validates :location, presence: true
    validates :email, presence: true
end
