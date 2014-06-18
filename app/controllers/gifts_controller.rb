class GiftsController < ApplicationController

    before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]

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
            redirect_to root_path, notice: 'Your gift has been successfully created!'
        else
            render :new, notice: 'Uh oh.'
        end
    end

    def edit
        @gift = Gift.find_by_id(params[:id])
    end

    def update
        @gift = Gift.find_by_id(params[:id])
    end 

    def destroy
        @gift = Gift.find_by_id(params[:id])
    end

    private

    def gift_params
        params.require(:gift).permit(:recipient_name, :relationship_to_gifter, :cause, :other_cause, :description, :user_id)
    end

end
