FactoryBot.define do
  factory :user do
    provider 'github'
    uid '12445'
    name {Faker::StarWars.character}
    login 'sdmalek44'
    token ENV['GITHUB_TEST_KEY']
    image {Faker::StarWars.vehicle}
  end
end
