class UploadsController < ApplicationController
  def index
  end
  
  def import
    old_count = Student.count
    Student.import(params[:file])
    new_count = Student.count
    records_added = (new_count - old_count).to_s
    flash[:success] = "#{records_added} New Records Imported!"
    redirect_to uploads_path
  end
end
