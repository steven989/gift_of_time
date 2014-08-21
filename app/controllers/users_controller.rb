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
        if current_user.admin? && params[:user][:admin_edit] == 'true'
            @user = User.find_by(id: params[:id])
        else    
            @user = current_user
        end
        @user.update_attributes(user_update_params)
        respond_to do |format|
            format.html {redirect_to user_profile_path, notice: @user.errors.full_messages.join(", ")}
            format.json {
                render json: {
                    message: @user.errors.full_messages.join(", "),
                    redirect_url: admin_path
                }
            }
        end
    end 

    def destroy
        if current_user.admin? && params[:admin_edit] == 'true'
            @user = User.find_by(id: params[:id])
        else    
            @user = current_user
        end

        @user.destroy 
        if params[:admin_edit] == 'true'
            redirect_to admin_path, notice: "User successfully deleted"
        else
            redirect_to root_path, notice: "User successfully deleted"
        end
    end 

    def profile
        @gifts = current_user.gifts.order('created_at desc')
        @user = current_user
        @in_progress_gifts = @user.gifts.where("status like 'In progress'").length
        @completed_gifts = @user.gifts.where("status like 'Completed'").length
        @completed_hours = @user.gifts.where("status like 'Completed'").sum('hours')
    end

    def admin
        @prices = Price.all
        @users = User.all.order(created_at: :desc)
        @total_users = @users.length

        @volunteers = Volunteer.all.order(created_at: :desc)
        @total_volunteers = @volunteers.length

        @gifts = Gift.all.order(created_at: :desc)
        @total_gifts = @gifts.length
        @total_hours = Gift.total_hours
        @total_printed = @gifts.select {|gift| !gift.certificate_printed_by_user.nil?}.length

    end

    def admin_update
        if params[:resource] == 'user'
            @user = User.find_by(id: params[:id])
            render partial: 'admin_user_update'
        elsif params[:resource] == 'gift'
            @gift = Gift.find_by(id: params[:id])
            render partial: 'admin_gift_update'
        elsif params[:resource] == 'volunteer'
            @volunteer = Volunteer.find_by(id:params[:id])
            render partial: 'admin_volunteer_update'
        elsif params[:resource] == 'price'
            @price = Price.find_by(id:params[:id])
            puts '---------------------------------------------------'
            puts @price.inspect 
            puts '---------------------------------------------------'
            render partial: 'admin_price_update'
        end
    end

    private

    def user_params
        params.require(:user).permit(:email,:password,:password_confirmation)
    end

    def user_update_params
        params.require(:user).permit(:email,:first_name, :last_name, :birthday, :city, :province, :country)
    end

end
