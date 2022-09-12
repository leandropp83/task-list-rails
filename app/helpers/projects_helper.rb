module ProjectsHelper

    def calc_project_progress(project)
        TasksController::calc_progress project.task
    end

    def getColor project
        ProjectsController.new.get_project_color project
    end

end
