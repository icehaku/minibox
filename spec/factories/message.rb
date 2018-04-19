FactoryBot.define do
  factory :message do
    content               { Faker::Lorem.paragraph(2) }
    title                 { Faker::Lorem.sentence }
    archived              false
    read                  false
    important             false
    destinatary_nickname  { Faker::Pokemon.name }

    trait :read do
      read       true
      read_date  Faker::Date.between(2.days.ago, Date.today)
    end

    trait :important do
      important  true
    end

    trait :archived do
      archived      true
      archive_date  Faker::Date.between(2.days.ago, Date.today)
    end
  end
end
