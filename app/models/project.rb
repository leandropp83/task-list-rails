class Project < ApplicationRecord
    validates_presence_of :name, :date_in, :date_end
    validates_length_of :name, minimum: 3
end
