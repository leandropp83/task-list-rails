FactoryBot.define do
    factory :task do
        association :project
        name { FFaker::Lorem.characters(5) }
        status { STATUS[:ativo] }
        checked { STATUS[:inativo] }
        date_in { FFaker::Time.between(DateTime.now + 30, DateTime.now + rand(30..60)) }
        date_end { FFaker::Time.between(DateTime.now + 60, DateTime.now + rand(60..90)) }
    end
  end