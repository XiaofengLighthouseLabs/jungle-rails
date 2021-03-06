require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They see product details" do
    # ACT

    visit root_path


    first('.product').click_link "Details"

    # DEBUG / VERIFY


    expect(page).to have_content (@category.products.first.name)
    expect(page).to have_content (@category.products.first.description)
    expect(page).to have_content (@category.products.first.quantity)
    expect(page).to have_content (@category.products.first.price)
    expect(page).to have_css '.product-detail', count: 1
    save_screenshot


  end

end
