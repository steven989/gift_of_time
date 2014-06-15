class UsersController < ApplicationController

    before_filter :require_login, except: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_path, notice: 'User successfully created.'
            auto_login @user
            GiftMailer.welcome_email(@user).deliver
        else 
            render :new
        end
    end 

    def edit
    end

    def update
    end 

    def destroy
    end 

    def profile
        @gifts = current_user.gifts
    end

    private

    def user_params
        params.require(:user).permit(:email,:password,:password_confirmation)
    end

end
