# frozen_string_literal: true

module Application
    module Services
        class TaskService < ApplicationService

            def calculate_progress tasks = nil
                tasks = TasksController.new.task_repository.all if tasks.nil?
                tasks.nil? || tasks.empty? ? 0 : calculate_percent(tasks)
            end

            def get_other_params task
                task[:status] = STATUS[:ativo]
                task[:checked] = STATUS[:inativo] if task[:checked].nil?
                task
            end

            private

            def get_checked_count tasks
                tasks.select { |t| t[:checked] }.count
            end

            def calculate_percent tasks        
                checked = get_checked_count(tasks)
                value = (checked.to_f / tasks.count.to_f) * 100
                value.floor
            end

        end
    end
end