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

  def delete_class_year
    class_year = params[:class_year]
    num_records = Student.where(:class_year => class_year).length
    Student.where(:class_year => class_year).destroy_all
    flash[:success] = "You have removed all #{num_records} records for #{class_year}!"
    redirect_to uploads_path
  end

end
