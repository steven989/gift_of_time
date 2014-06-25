class Gift < ActiveRecord::Base

    belongs_to :user
    mount_uploader :volunteer_photos, VolunteerPhotoUploader

    def self.total_hours
        Gift.all.sum(:hours)
    end

    def create_secure_gift_id
        while true
            id = SecureRandom.hex(4).upcase
            break unless Gift.all.map {|gift| gift.gift_comp_id}.include? id
        end
        self.update_attribute(:gift_comp_id, id) if self.gift_comp_id.blank? || self.gift_comp_id.nil?
        self.gift_comp_id
    end

    def photo_exists?
        if self.volunteer_photos.file.nil? 
            false
        else
            self.volunteer_photos.file.exists?
        end
    end

    def attempt_complete
        self.update_attribute(:status, 'Completed') if self.photo_exists?
    end
    
end
