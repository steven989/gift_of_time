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
            message = "Your gift has been successfully designed! Now perform the act. When you're done, come back to complete your gift. Don't forget to take a picture."
        else
            message = 'Uh oh. Something went wrong.'
        end

        respond_to do |format|
            format.json {
                render json: {
                    message: message,
                    redirect_url: user_profile_path
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
            format.html {
                if params[:todo] == 'complete' && @gift.status == 'Completed'
                redirect_to checkout_path(@gift.gift_comp_id), notice: "You gift has been successfully created!"
                else 
                redirect_to user_profile_path, notice: @gift.errors.full_messages.join(", ")
                end
            }
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
            redirect_to complete_gift_path(@gift.gift_comp_id)
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

    def checkout
        @gift = Gift.find_by(gift_comp_id: params[:gift_id])
        @giftid = params[:gift_id]
        @key = ENV['STRIPE_PUBLISH_KEY']
        @price_plaque = Price.find_by(item: 'plaque').price_in_cents
        @price_frame = Price.find_by(item: 'frame').price_in_cents
    end


    def donate
        @key = ENV['STRIPE_PUBLISH_KEY']
        @giftid = params[:gift_id]
    end

    def download
        @giftid = params[:gift_id]
    end

    private

    def gift_params
        params.require(:gift).permit(:recipient_name, :relationship_to_gifter, :cause, :other_cause, :description, :user_id, :inspiration, :feel, :detailed_message, :volunteer_photos, :hours, :organization, :expected_hours, :expected_completion_date)
    end

end
