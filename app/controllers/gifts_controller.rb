class GiftsController < ApplicationController

    before_filter :require_login, only: [:new, :create, :edit, :update, :complete, :destroy]

    def find
    end

    def show
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])
    end

    def new
        @gift = Gift.new
    end

    def create
        params[:gift][:user_id] = current_user.id
        @gift = Gift.new(gift_params)

        if @gift.save
            id = @gift.create_secure_gift_id
            @gift.update_attribute(:status, 'In progress')
            redirect_to user_profile_path, notice: 'Your gift has been successfully created!'
        else
            render :new, notice: 'Uh oh.'
        end
    end

    def edit
        @gift = Gift.find_by(gift_comp_id: params[:id])
    end

    def update
        @gift = Gift.find_by(gift_comp_id: params[:id])
        @gift.update_attributes(gift_params)
        redirect_to user_profile_path, notice: 'Your gift has been updated'
        @gift.attempt_complete
    end 

    def complete        
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])
    end

    def remove_photo
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])
        @gift.remove_volunteer_photos!
        redirect_to edit_gift_path(@gift.gift_comp_id), notice: 'Your gift has been updated'
    end

    def destroy
        @gift = Gift.find_by(gift_comp_id: params[:id])
        @gift.destroy
        redirect_to user_profile_path, notice: 'Your gift has been deleted'
    end

    def certificate
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])
        respond_to do |format|
            format.html {
                pdf = Certificate.new(@gift, view_context)
                pdf.generate
                send_data pdf.render, filename: "#{Date.today.strftime("%d/%m/%Y")} Gift for for #{@gift.recipient_name}.pdf", type: "application/pdf"

            }
        end
    end 

    private

    def gift_params
        params.require(:gift).permit(:recipient_name, :relationship_to_gifter, :cause, :other_cause, :description, :user_id, :inspiration, :feel, :detailed_message, :volunteer_photos)
    end

end
