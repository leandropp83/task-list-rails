class Project < ApplicationRecord
    validates_presence_of :name, :date_in, :date_end
    validates_length_of :name, minimum: 3
    validates :date_end, comparison: { greater_than: :date_in,
        message: "A data final deve ser maior que a data inicial" }
end
