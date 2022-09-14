class Project < ApplicationRecord
    has_many :task, dependent: :destroy
    validates_presence_of :name, :date_in, :date_end
    validates_length_of :name, minimum: 3
    validates :date_end, comparison: { greater_than: :date_in,
        message: " deve ser maior que a data inicial" }
    validates :name, uniqueness: true
    validate :is_date?

    private

    def is_date?
        begin
            Date.parse(date_in.to_s).is_a?(Date)            
            Date.parse(date_end.to_s).is_a?(Date)                
        rescue
            errors.add(:data, 'inválida') 
        end
    end

end
