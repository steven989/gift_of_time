class PagesController < ApplicationController

    def index
        @total_gifted_hours = Gift.total_hours        
    end


end
