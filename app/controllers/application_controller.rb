class ApplicationController < ActionController::Base

    include SessionsHelper
    def temporary
        render 'layouts/temporary'
    end

    private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end


    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(visualization_path) unless @user == current_user
    end
end
