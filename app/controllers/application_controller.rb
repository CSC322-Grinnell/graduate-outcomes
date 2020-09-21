class ApplicationController < ActionController::Base
    def visualize
         render "features/visualize"
    end
    
    def create
         render "features/create"
    end
    
    def upload
         render "features/upload"
    end
end
