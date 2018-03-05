require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do


  before :each do
    @user = User.create!(name:"Grace", email:"grace@example.com", password:"test1234", password_confirmation:"test1234")

  end

  scenario "They see user login" do
    # ACT

    visit '/login'


    fill_in 'email', with: 'grace@example.com'
    fill_in 'password', with: 'test1234'
    click_on 'Submit'

    expect(page).to have_content('Signed in as Grace')
    expect(page).to have_content('Logout')

    save_screenshot

  end

end


