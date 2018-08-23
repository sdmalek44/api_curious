FactoryBot.define do
  factory :user do
    provider 'github'
    uid '12445'
    name 'Stephen Malek'
    login 'sdmalek44'
    token ENV['GITHUB_TEST_KEY']
    image 'image'
  end
end
