class ValidEmailsController < ApplicationController
  before_action :logged_in_user, only: [:index]

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
      render 'new'
    end
  end

  private

  def valid_email_params
    params.permit(:email)
  end
end
