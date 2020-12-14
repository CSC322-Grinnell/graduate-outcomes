class VisualizationsController < ApplicationController
  before_action :set_visualization, only: [:show, :edit, :update, :destroy]

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
    2.times { @visualization.variables.build }
    2.times { @visualization.filters.build }
  end

  def create

      @visualization = Visualization.new(visualization_params)
      if @visualization.save
         flash[:success] = "Visualization created!"
         redirect_to @visualization #show visualization that was just created
      else
        render 'new'
      end
  end

  def update
    if @visualization.update(visualization_params)
      flash[:success] = "Visualization updated!"
      redirect_to @visualization #show visualization that was just update
    else
      flash[:error] = "Visualization could not be updated. Please fill all fields and try again!"
      redirect_to visualizations_path # ideally stay on edit and show error messages but it appears to be building extra variables/filters
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
