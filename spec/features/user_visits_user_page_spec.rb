require 'rails_helper'

describe 'user visits /dashboard' do
  xit 'sees a list of all followers of the user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(page).to have_css('.starred', count: 3)
  end
end
