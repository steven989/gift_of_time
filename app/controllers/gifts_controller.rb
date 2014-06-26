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
            GiftMailer.next_step_email(current_user, @gift).deliver
            message = "Your gift has been successfully created! Now perform the act. When you are done, come back to complete your gift with the detail of your act along with a picture."
        else
            message = 'Uh oh. Something went wrong.'
        end

        respond_to do |format|
            format.json {
                render json: {
                    message: message,
                    redirect_url: new_gift_path
                }
            }
        end

    end

    def edit
        @gift = Gift.find_by(gift_comp_id: params[:id])
    end

    def update
        @gift = Gift.find_by(gift_comp_id: params[:id])
        @gift.update_attributes(gift_params)

        @gift.attempt_complete
        respond_to do |format|
            format.html {redirect_to user_profile_path, notice: @gift.errors.full_messages.join(", ")}
            format.json {
                render json: {
                    message: @gift.errors.full_messages.join(", "),
                    redirect_url: admin_path
                }
            }
        end
    end 

    def complete        
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])
    end

    def remove_photo
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])
        @gift.remove_volunteer_photos!

        if params[:admin_edit] == 'true'
            redirect_to admin_path
        else
            redirect_to edit_gift_path(@gift.gift_comp_id)
        end
    end

    def destroy
        if params[:admin_edit] == 'true'
            @gift = Gift.find_by(id: params[:id])
        else
            @gift = Gift.find_by(gift_comp_id: params[:id])
        end
        @gift.destroy
        if params[:admin_edit] == 'true'
            redirect_to admin_path, notice: "Gift successfully deleted"
        else
            redirect_to user_profile_path, notice: "Gift successfully deleted"
        end
    end

    def certificate
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])

        if params[:admin_edit].nil?
            @gift.update_attribute(:certificate_printed_by_user, DateTime.now.in_time_zone('UTC').strftime('%Y-%m-%d %H:%M:%S UTC'))
        end

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
        params.require(:gift).permit(:recipient_name, :relationship_to_gifter, :cause, :other_cause, :description, :user_id, :inspiration, :feel, :detailed_message, :volunteer_photos, :hours, :organization)
    end

end
