class VisualizationsController < ApplicationController
  def index
    @visualizations = Visualization.order(updated_at: :desc)
  end

  def show
    @visualization = Visualization.find(params[:id])
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
  
  private
  
    def visualization_params
      params.require(:visualization).permit(:chart_type, 
                                            :x_axis_title, 
                                            :y_axis_title, 
                                            :chart_title, 
                                            variables_attributes: [:name, :role],
                                            filters_attributes: [:variable_name, :filter_type, :value1, :value2]
                                          )
    end
  
end
