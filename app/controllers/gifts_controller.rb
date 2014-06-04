class GiftsController < ApplicationController

    def find
    end

    def show
        @gift = Gift.find_by_id(params[:gift_id])
    end

    def new
        @gift = Gift.new
    end

    def create
        @gift = Gift.new(gift_params)

        if @gift.save
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
        params.require(:gift).permit(:gift_name, :message)
    end

end