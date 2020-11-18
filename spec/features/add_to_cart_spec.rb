require 'rails_helper'

RSpec.feature "Visitor adds to cart and sees the cart button in nav change", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click add" do
    # ACT
    visit root_path
    
    expect(page).to have_content "My Cart (0)"
    # save_screenshot

    first("article.product").find_button('Add').click
    expect(page).to have_content "My Cart (1)"

    # DEBUG / VERIFY
    # save_screenshot
    # puts page.html
  end

end
