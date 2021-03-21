class ValidEmailsController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]

  def index
    @valid_emails = ValidEmail.all
  end

  def new
    @valid_email = ValidEmail.new
  end

  def create
    @valid_email = ValidEmail.new(valid_email_params)
    if @valid_email.save
      redirect_to valid_emails_path
    else
      redirect_to valid_emails_path
    end
  end


  def destroy
    @user = User.find_by(email: ValidEmail.find(params[:id]).email)
    unless @user.nil?
      @user.destroy
    end
    ValidEmail.find(params[:id]).destroy
    flash[:success] = "Email deleted"
    redirect_to valid_emails_path
  end

  private

  def valid_email_params
    params.permit(:email)
  end
end
