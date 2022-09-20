module Application
    module Repository
        class TaskRepository  

            def initialize
                @model = Task
            end

            def set_task id
                @task = @model.find(id)
            end

            def all
                @model.all
            end

        end
    end
end