class SessionsController < ApplicationController

    def new
    end

    def create
        if @user = login(params[:email], params[:password])
            redirect_back_or_to root_path, notice: 'Login successful'
        else 
            flash.now[:notice] = 'Login failed'
            render :new
        end
    end

    def destroy
        logout
        redirect_to root_path
    end 

end
