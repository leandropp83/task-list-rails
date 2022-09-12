class Task < ApplicationRecord
    belongs_to :project
    validates_presence_of :name, :date_in, :date_end, :project_id
    validates_length_of :name, minimum: 3
    validates :date_end, comparison: { greater_than: :date_in,
        message: " deve ser maior que a data inicial" }
    validate :check_project_date
    
    def check_project_date
        project = Project.find(project_id)
        if date_in < project.date_in
            errors.add(:date_in, " precisa ser maior que #{project.date_in.strftime("%m/%d/%Y %H:%M:%S")}")
        end
    end

end