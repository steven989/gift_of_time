require 'open-uri'

class Certificate < Prawn::Document
    def initialize(gift, view)
        super()
        @gift = gift
        @view = view
        text "Gift #{@gift.gift_comp_id}"
    end

    def generate
        text "From #{@gift.user.display_name} to #{@gift.recipient_name}"
        text "Total hours donated: #{@gift.hours}" if @gift.hours
        text "What I did:"
        text "#{@gift.description}"
        text "How did you inspire me to do it:"
        text "#{@gift.inspiration}"
        text "Message:"
        text "#{@gift.detailed_message}"
        image open(@gift.volunteer_photos.url) if @gift.photo_exists?
    end

end
