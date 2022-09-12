module ProjectsHelper

    def progress(progress, legend = nil)
        str = ''
        unless legend.nil?
            str +=
            '<div class="row justify-content-end align-items-center">'
        end
            str += 
            '<div class="progress w-100 px-0">
                <div class="progress-bar" role="progressbar" style="width:' + progress.to_s + '%;" aria-volumenow="' + progress.to_s + '" aria-volumemin="0" aria-volumemax="100">
                    ' + progress.to_s + '%
                </div>
            </div>'
        unless legend.nil?
            str +=
                '<div class="col-auto">
                        <p class="mb-0">' + legend.to_s + '</p>
                </div>
            </div>'
        end        
        str.html_safe
    end

    def calc_project_progress(project)
        TasksController::calc_progress project.task
    end

end
