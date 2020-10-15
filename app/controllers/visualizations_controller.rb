class VisualizationsController < ApplicationController
  def index
    
  end

  def show
    
  end

  def new
    @visualization = Visualization.new
    2.times { @visualization.variables.build }
  end

  def create
      @visualization = Visualization.new(visualization_params)
      if @visualization.save
         flash[:success] = "Visualization created!"
         redirect_to visualizations_path
      else
         redirect_to new_visualization_path
      end
  end
  
  private
  
    def visualization_params
      params.require(:visualization).permit(:chart_type, 
                                            :x_axis_title, 
                                            :y_axis_title, 
                                            :chart_title, 
                                            variables_attributes: [:name, :role],
                                            filters_attributes: [:variable_name, :type, :value1, :value2]
                                          )
    end
  
end
