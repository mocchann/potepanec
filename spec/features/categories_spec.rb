require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy, name: 'Category') }
  given(:taxon) { taxonomy.root }
  given(:bag) { create(:taxon, name: 'Bag', taxonomy: taxonomy, parent: taxon) }
  given(:clothing) { create(:taxon, name: 'Clothing', taxonomy: taxonomy, parent: taxon) }
  given(:categories) { create(:taxon, name: 'Shirts', taxonomy: taxonomy, parent: clothing) }
  given!(:product1) { create(:product, name: 'bag', price: 10, taxons: [bag]) }
  given!(:product2) { create(:product, name: 'shirts', price: 20, taxons: [categories]) }

  background do
    visit potepan_category_path(categories.id)
  end

  scenario "display correct categories page" do
    expect(page).to have_title categories.name

    within '.side-nav' do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content bag.name
      expect(page).to have_content categories.name
      expect(page).not_to have_content clothing.name
    end

    within '.productBox' do
      expect(page).to have_content product2.name
      expect(page).to have_content product2.display_price
      expect(page).not_to have_content product1.name
      expect(page).not_to have_content product1.display_price
    end
  end

  scenario "move correct page from category link" do
    click_on bag.name
    expect(current_path).to eq potepan_category_path(bag.id)

    within '.productBox' do
      expect(page).to have_content product1.name
      expect(page).to have_content product1.display_price
      expect(page).not_to have_content product2.name
      expect(page).not_to have_content product2.display_price
    end
  end

  scenario "move correct page from product link" do
    click_on product2.name
    expect(current_path).to eq potepan_product_path(product2.id)

    within '.singleProduct' do
      expect(page).to have_content product2.name
      expect(page).to have_content product2.display_price
      expect(page).not_to have_content product1.name
      expect(page).not_to have_content product1.display_price
    end
  end

  scenario "return to list page" do
    visit potepan_product_path(product1.id)
    within '.fa-reply'
    click_on '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(bag.id)
  end

  scenario "the number of products matches the number of products listed" do
    expect(all('.productbox').size).to eq taxon.products.count
  end

  scenario "products in different categories are not included" do
    click_on bag.name
    expect(page).not_to have_content product2.name
    expect(page).not_to have_content product2.display_price
  end
end
