# Controller for all visualization form and rendering

# Soruce for dynamic form fields:
# https://rbudiharso.wordpress.com/2010/07/07/dynamically-add-and-remove-input-field-in-rails-without-javascript/

class VisualizationsController < ApplicationController
  before_action :set_visualization, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  def index
    @visualizations = Visualization.order(updated_at: :desc)
  end

  #set associated model's foreign keys to nil
  # or find associated models and delete them 
  # variables and filters 
  def delete_visualization
    @id = Visualization.find(params[:id])
    Visualization.find(params[:id]).filters.destroy_all
    Visualization.find(params[:id]).variables.destroy_all
    @id.destroy
    flash[:success] = "You have deleted the visualization!"
    redirect_to visualizations_path
  end

  def show
  end

  def edit
  end

  def new
    @visualization = Visualization.new
    @visualization.variables.build
    @visualization.filters.build
  end

  def create
    @visualization = Visualization.new(visualization_params)
    if params[:add_variable] # if button selected to add var, re-render form
      @visualization.variables.build
      render 'new'
    elsif params[:remove_variable]
      render 'new'
    elsif params[:add_filter] # if button selected to add filt, re-render form
      # add empty filter associated with @visualization
      @visualization.filters.build
      render 'new'
    elsif params[:remove_filter]
      # nested models that have _destroy attribute = 1 automatically deleted by rails (except not working!!)
      render 'new'
    else
      # save
      if @visualization.save
         flash[:success] = "Visualization created!"
         redirect_to @visualization #show visualization that was just created
      else
        render 'new'
      end
    end
  end

  def update
    @visualization = Visualization.find(params[:id])
    if params[:add_variable]
    	# rebuild the variable attributes that don't have an id
    	unless params[:variable][:variables_attributes].blank?
	  for attribute in params[:variable][:variables_attributes]
	    @visualization.variables.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	  end
    	end
      # add one more empty variable attribute
        @visualization.variables.build
        render :action => 'edit' # re-render form
    elsif params[:remove_variable]
      # collect all marked for delete variable ids
      removed_variables = params[:visualization][:variables_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
      # physically delete the variables from database (NOT WORKING!!)
      Visualization.delete(removed_variables)
      flash[:notice] = "Variables removed."
      for attribute in params[:visualization][:variables_attributes]
      	# rebuild variables attributes that don't have an id and whose _destroy attribute is not 1
        @visualization.variables.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      end
      render :action => 'edit'
    elsif params[:add_filter]
    	# rebuild the filter attributes that don't have an id
    	unless params[:filter][:filters_attributes].blank?
	  for attribute in params[:filter][:filters_attributes]
	    @visualization.filters.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	  end
    	end
      # add one more empty filter attribute
        @visualization.filters.build
        render :action => 'edit'
    elsif params[:remove_filter]
      # collect all marked for delete filter ids
      removed_filters = params[:visualization][:filters_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
      # physically delete the filters from database (NOT WORKING!!)
      Visualization.delete(removed_filters)
      flash[:notice] = "Filters removed."
      for attribute in params[:visualization][:filters_attributes]
      	# rebuild filter attributes that dont't have an id and whose _destroy attribute is not 1
        @visualization.filters.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      end
      render :action => 'edit' # re-render
    else
      # save
      if @visualization.update(visualization_params)
        flash[:success] = "Visualization updated!"
        redirect_to @visualization #show visualization that was just updates
      else
        flash[:error] = "Visualization could not be updated. Please fill all fields and try again!"
        redirect_to visualizations_path # ideally stay on edit and show error messages but it appears to be building extra variables/filters
      end
    end
  end
  
  private
    def set_visualization
      @visualization = Visualization.find(params[:id])
    end
    
    def visualization_params
      params.require(:visualization)
            .permit(:chart_type, 
                    :x_axis_title, 
                    :y_axis_title, 
                    :chart_title, 
                    variables_attributes: [:name, :role],
                    filters_attributes: [:variable_name, :filter_type, :value1, :value2])
      
    end  

end
