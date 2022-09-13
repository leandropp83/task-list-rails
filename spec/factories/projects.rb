FactoryBot.define do
    factory :project do
      name { FFaker::Lorem.characters(5) }
      status { STATUS[:ativo] }
      date_in { FFaker::Time.between(DateTime.now - 1, DateTime.now + rand(1..30)) }
      date_end { FFaker::Time.between(DateTime.now + 30, DateTime.now + rand(30..60)) }
    end
    trait :with_task do
        after(:create) do |project|
          create(:task, project_id: project.id)
        end
    end
    trait :with_checked_task do
        after(:create) do |project|
            create(:task, project_id: project.id, checked: STATUS[:ativo])
        end
    end
  end