require 'rails_helper'

describe 'user visits /repos' do
  it 'sees a list of all followers of the user' do
    user = create(:user)

    stub_request(:get, "https://api.github.com/users/#{user.login}/repos?page=1").to_return(status: 200, body: File.read('./spec/mock_requests/repos.json'))

    stub_request(:get, "https://api.github.com/users/#{user.login}/repos?page=2").to_return(status: 200, body: File.read('./spec/mock_requests/repos-2.json'))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit repos_path

    expect(page).to have_content("#{user.name}'s Repositories")
    expect(page).to have_css('.repo', count: 40)
    within(first('.repo')) do
      expect(page).to have_css('.repo-name')
      expect(page).to have_css('.repo-url')
    end
  end
end
