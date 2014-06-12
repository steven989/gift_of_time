class Gift < ActiveRecord::Base

    belongs_to :user


    def create_secure_gift_id
        while true
            id = SecureRandom.hex(4).upcase
            break unless Gift.all.map {|gift| gift.gift_comp_id}.include? id
        end
        self.update_attribute(:gift_comp_id, id) if self.gift_comp_id.blank? || self.gift_comp_id.nil?
        self.gift_comp_id
    end
    
end
