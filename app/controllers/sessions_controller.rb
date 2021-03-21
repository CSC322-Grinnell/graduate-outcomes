class SessionsController < ApplicationController
  def new
  end

  # for logging in the user or rejecting invalid users
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to visualizations_path
      flash[:success] = "Logged in!"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
    flash[:success] = "Logged out!"
  end
end
