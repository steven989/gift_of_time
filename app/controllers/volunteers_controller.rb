class VolunteersController < ApplicationController

    def index
        @notice = flash[:notice]
        @min_date = Date.today - 30.days
        @volunteers = Volunteer.where("created_at >= '#{@min_date}'").order(created_at: :desc)
        @volunteer = Volunteer.new
    end

    def create
        @volunteer = Volunteer.new(volunteer_params)

        if @volunteer.save
            redirect_to volunteers_path, notice: 'Volunteer successfully added!'
        else
            redirect_to volunteers_path, notice: @volunteer.errors.full_messages.join(' ')
        end
    end

    def edit
    end 

    def update
    end

    def destroy
    end

    private

    def volunteer_params
        params.require(:volunteer).permit(:title,:description,:organization,:hours,:location,:contact_name,:email)
    end

end
