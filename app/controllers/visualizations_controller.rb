# Controller for all visualizations, form and rendering

# Soruce for dynamic form fields:
# https://rbudiharso.wordpress.com/2010/07/07/dynamically-add-and-remove-input-field-in-rails-without-javascript/

class VisualizationsController < ApplicationController
  before_action :set_visualization, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  def index
    @visualizations = Visualization.order(updated_at: :desc)
  end

  # Deletes the current visualization.
  # set associated model's foreign keys to nil
  # or find associated models and delete them
  # destroy variables and filters
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

  # Editing visualization:
  # Gets visualization params for edit form
  def edit
    @visualization = Visualization.find(params[:id])
  end

  # Creates new visualization and adds initial variable and filter fields
  # for visualization form
  def new
    @visualization = Visualization.new
    @visualization.variables.build
    @visualization.filters.build
  end

  # Upon submitting form, creates the visualization based on selections.
  def create
    @visualization = Visualization.new(visualization_params) # get params

    ## Adding and Deleting Variables: ##
    if params[:add_variable] # if user clicked "Add variable" button
      @visualization.variables.build # create new variable
      render 'new' # re-render form
    elsif params[:remove_variable] # if user clicked "Delete checked variables"
      # nested models that have _destroy attribute == 1 automatically deleted
      render 'new' # re-render form

    ## Adding and Deleting Filters: ##
    elsif params[:add_filter] # if user clicked "Add filter" button
      # add empty filter associated with @visualization
      @visualization.filters.build
      render 'new' # re-render form
    elsif params[:remove_filter] # if user clicked "Delete checked filters"
      # nested models that have _destroy attribute == 1 automatically deleted
      render 'new' # re-render form

    ## Creating the Form ##
       # (if user clicked "Create Visualization!" button)
    else
      # save the form
      if @visualization.save
         flash[:success] = "Visualization created!" # confirmation message
         redirect_to @visualization and return #show the created visualization
      else
        render 'new'  # show errors and stay on form
      end
    end
  end

  # Upon submitting edit form, updates the visualization based on selections.
  def update
    @visualization = Visualization.find(params[:id]) # fetch visualzation params
    params.permit! ## ** UNSAFE -- Should change at some point! (Ask mentor) **

    ## Adding Variables: ##
    if params[:add_variable] # if user clicked "Add variable" button
    	# rebuild the variable attributes that don't have an id
    	unless params[:visualization][:variables_attributes].blank?
	  for attribute in params[:visualization][:variables_attributes]
	    @visualization.variables.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	  end
    	end
      # add one more empty variable attribute
        @visualization.variables.build
        render 'edit' # re-render form

    ## Deleting Variables: ##
    elsif params[:remove_variable] # if user clicked "Delete checked variables"
      # physically delete the variables from database
      for attribute in params[:visualization][:variables_attributes]
        @visualization.variables.destroy(attribute.last[:id]) if (attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 1)
      end
      flash[:success] = "Variables removed."
      for attribute in params[:visualization][:variables_attributes]
      	# rebuild variables attributes that don't have an id
        # and whose _destroy attribute is not 1
        @visualization.variables.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      end
      render 'edit'

    ## Adding Filters: ##
    elsif params[:add_filter] # if user clicked "Add filter" button
    	# rebuild the filter attributes that don't have an id
    	unless params[:visualization][:filters_attributes].blank?
	  for attribute in params[:visualization][:filters_attributes]
	    @visualization.filters.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	  end
    	end
        @visualization.filters.build # add one more empty filter attribute
        render 'edit' # re-render

    ## Deleting Filters: ##
    elsif params[:remove_filter] # if user clicked "Delete checked filters"
      # physically delete the filters from database
      for attribute in params[:visualization][:filters_attributes]
        @visualization.filters.destroy(attribute.last[:id]) if (attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 1)
      end
      flash[:success] = "Filters removed."
      for attribute in params[:visualization][:filters_attributes]
      	# rebuild filter attributes that dont't have an id
        # and whose _destroy attribute is not 1
        @visualization.filters.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      end
      render 'edit' # re-render

    ## Updating the Form ##
      # (if user clicked "Create Visualization!" button)
    else
      # save changes
      if @visualization.update(visualization_params)
        flash[:success] = "Visualization updated!"
        redirect_to @visualization and return # display updated visualization
      else
        flash[:error] = "Visualization could not be updated. Please fill all fields and try again!"
        render 'edit' # show errors and stay on form
      end
    end
  end
  
  private
    def set_visualization
      @visualization = Visualization.find(params[:id])
    end

    # Parameters for each visualization
    def visualization_params
      ActionController::Parameters.permit_all_parameters = true
      
      params.require(:visualization)
            .permit(:chart_type, 
                    :x_axis_title, 
                    :y_axis_title, 
                    :chart_title, 
                    variables_attributes: [:name, :role, :_destroy, :id],
                    filters_attributes: [:variable_name, :filter_type, :value1, :value2, :_destroy, :id])
      
    end
end
