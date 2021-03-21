class UploadsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  # import CSV data and catch errors related to it
  def import
    old_count = Student.count

    begin
    Student.import(params[:file])
    new_count = Student.count
    records_added = (new_count - old_count).to_s
    flash[:success] = "#{records_added} New Records Imported!"

    #render :text => "File has been uploaded successfully"
    redirect_to uploads_path

    rescue CSV::MalformedCSVError
     flash[:error] = "File is not a CSV file"
     redirect_to uploads_path

    rescue ActiveModel::UnknownAttributeError
     flash[:error] = "Please make sure file headers match the given format"
     redirect_to uploads_path

    rescue Exception
     flash[:error] = "Unknown error. Please double-check your file"
     redirect_to uploads_path

    end
  end

  # delete all csv data from specific class year 
  def delete_class_year
    class_year = params[:class_year]
    num_records = Student.where(:class_year => class_year).length
    Student.where(:class_year => class_year).destroy_all
    flash[:success] = "You have removed all #{num_records} records for #{class_year}!"
    redirect_to uploads_path
  end

end
