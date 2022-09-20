module ProjectsHelper

    def calculate_project_progress(project)
        TasksController.new.task_service.calculate_progress project.task
    end

    def get_color project
        ProjectsController.new.get_project_color project
    end

end
