class ApplicationController < ActionController::Base
    def visualize
         render html: "This is dashboard page"
    end
    
    def create
         render html: "This is create visualization page"
    end
    
    def upload
         render html: "This is upload data page"
    end
end
