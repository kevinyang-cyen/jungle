require 'rails_helper'

RSpec.feature "Visitor logins with correct information", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!({
      first_name: 'first',
      last_name: 'last',
      email: 'firstlast@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    })
  end

  scenario "They try to login" do
    # ACT
    visit '/login'

    fill_in 'email', with: 'firstlast@gmail.com'
    fill_in 'password', with: '12345'
    find_button('Submit').click
    expect(page).to have_content "Login"

    # DEBUG / VERIFY
    # save_screenshot
    # puts page.html

    fill_in 'email', with: 'firstlast@gmail.com'
    fill_in 'password', with: '123456'
    find_button('Submit').click

    expect(page).to have_content "Products"

    # DEBUG / VERIFY
    # save_screenshot
    # puts page.html
  end

end
