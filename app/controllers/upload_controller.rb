class UploadController < ApplicationController
  def index
  end
  
  def import
    @str = "Hello"
    Student.import(params[:file])
    flash[:notice] = "Success"
  end
end
