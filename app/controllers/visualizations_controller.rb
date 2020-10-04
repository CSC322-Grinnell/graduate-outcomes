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
  end
end
