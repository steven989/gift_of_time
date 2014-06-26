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
        @message = flash[:notice]
        @user = current_user
    end

    def update
        @user = current_user
        @user.update_attributes(user_update_params)
        redirect_to edit_user_path(current_user), notice: @user.errors.full_messages.join(", ")
    end 

    def destroy
    end 

    def profile
        @gifts = current_user.gifts.order('created_at desc')
    end

    def admin
        @users = User.all
        @gifts = Gift.all
    end

    private

    def user_params
        params.require(:user).permit(:email,:password,:password_confirmation)
    end

    def user_update_params
        params.require(:user).permit(:email,:first_name, :last_name, :birthday, :city, :province, :country)
    end

end
