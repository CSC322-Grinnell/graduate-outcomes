  class VisualizationsController < ApplicationController
  before_action :set_visualization, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  # shows a listing (i.e. previews) of existing visualizations stored in the database
  def index
    @visualizations = Visualization.order(updated_at: :desc)
  end

  # removes an existing visualization from the database 
  # and sends the user to the index page
  # prereq: call to set_visualization
  # filters are NOT implemented anymore. Refactor code.
  def destroy
    @visualization.filters.destroy_all
    @visualization.variables.destroy_all
    @visualization.destroy
    flash[:success] = "You have deleted the visualization!"
    redirect_to visualizations_url
  end

  # retrieves an existing visualization from the database and displays it
  # prereq: call to set_visualization
  def show
  end

  # Renders a form for user to specify options for a new visualization
  def new
    # informs "new visualization" form about what a visualization model is
    @visualization = Visualization.new
    @visualization.variables.build
    @visualization.variables.build
  end

  # Reads chart options specified by new form. Then, creates and renders 
  # a new visualization with the appropriate chart options
  def create
    @visualization = Visualization.new(permitted_params) 
    
    if @visualization.save()
      flash[:success] = "Visualization created!" # confirmation message
      render 'show'
    else
      flash[:error] = "Visualization could not be created."
      render 'new'
    end
  end
  
  # renders a form for user to change (options for) an existing visualization
  # prereq: call to set_visualization  
  def edit
  end

  # Reads new chart options for an existing visualization specified by edit form.
  # Then, creates and renders updated version of that visualization.
  # prereq: call to set_visualization  
  def update
    is_success = @visualization.update(permitted_params)
    
    # update variables in visualization one by one
    variables_params = permitted_params["variables_attributes"]
    len = variables_params.to_h.length
    (0...len).each() do |i|
      var = @visualization.variables[i]
      var_name = variables_params["#{i}"]["name"]
      var_role = variables_params["#{i}"]["role"]
      is_success = is_success && var.update(name: var_name, role: var_role)
    end
    # is_success is true if and only if ALL update calls yielded true
    
    if is_success
      flash[:success] = "Visualization updated!"
      render 'show'
    else
      flash[:error] = "Visualization could not be updated. Please fill all fields and try again!"
      render 'edit'
    end
  end
  
  private
    def set_visualization
      @visualization = Visualization.find(params[:id])
    end

     # Filters_attributes may be unused. Remove or fix as a feature (due to unused apply_filter method in app/helpers/visualizations_helper.rb)
     # Checks Requirements for Strong Parameters coming from submitted (new and edit) forms
    def permitted_params
      params.require(:visualization)
            .permit(:chart_type, 
                    :x_axis_title, 
                    :y_axis_title, 
                    :chart_title, 
                    variables_attributes: [:name, :role, :_destroy, :id],
                    filters_attributes: [:variable_name, :filter_type, :value1, :value2, :_destroy, :id])
      
    end
  end