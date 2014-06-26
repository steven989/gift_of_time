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
        @volunteer = Volunteer.find_by(id: params[:id])
        @volunteer.update_attributes(volunteer_params)

        respond_to do |format|
            format.html {redirect_to volunteers_path, notice: @volunteer.errors.full_messages.join(", ")}
            format.json {
                render json: {
                    message: @volunteer.errors.full_messages.join(", "),
                    redirect_url: admin_path
                }
            }
        end
    end

    def destroy
        @volunteer = Volunteer.find_by(id: params[:id])
        @volunteer.destroy
        if params[:admin_edit] == 'true'
            redirect_to admin_path, notice: "Volunteer successfully deleted"
        else
            redirect_to volunteers_path, notice: "Gift successfully deleted"
        end
    end

    private

    def volunteer_params
        params.require(:volunteer).permit(:title,:description,:organization,:hours,:location,:contact_name,:email)
    end

end
