module Application
    module Repository
        class ProjectRepository            

            def initialize order, current_page
                @model = Project
                @order = order
                @current_page = current_page
            end            

            def set_project
                @project = @model.find(@params[:id])
            end

            def get_projects
                @model.order(@order).paginate(:page => @current_page)
            end
            
        end
    end
end

