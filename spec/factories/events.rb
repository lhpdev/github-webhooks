FactoryBot.define do
  factory :event do
    action { ['opened', 'closed', 'edited', 'reopened', 'pinned' ].sample }
    sequence :number do |n|
      "#{n}"
    end  
    created_at { Time.now }
  end
end
