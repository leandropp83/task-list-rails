# frozen_string_literal: true

module Application
    module Services
        class ProjectService < ApplicationService
            
            include ProjectConcern

            def initialize projects
                @projects = projects
            end

            def calculate_total_project_progress
                if @projects.empty?
                    return 0
                end
                value = ( is_completed_count.to_f / @projects.count.to_f ) * 100
                value.floor
            end

            def get_project_color project
                if project.task.empty?
                    return ""
                end
                completed = self.is_completed project.task
                delayed = self.get_delayed_project project
                if completed
                    return "checked"
                end
                !delayed.empty? ? " delayed" : ""
            end

            private

            def get_delayed_project project
                project.task.select{|task| is_delayed(task[:date_end], project[:date_end]) }
            end

            def is_completed tasks
                checked_list = tasks.select { |value| value[:checked] == false }
                !tasks.empty? && checked_list.empty?
            end

            def is_completed_count
                @projects.select { |val| is_completed(val.task) }.count
            end

        end
    end
end