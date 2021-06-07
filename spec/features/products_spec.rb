require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "商品詳細表示" do
    given(:product) { create(:product) }

    background { visit potepan_product_path(product.id) }

    scenario "各商品の詳細表示" do
      expect(page).to have_title "#{product.name} - BIGBAG Store"
      expect(page).to have_selector '.page-title h2', text: product.name
      expect(page).to have_selector '.col-xs-6 li', text: product.name
      expect(page).to have_selector '.media-body h2', text: product.name
      expect(page).to have_selector 'h3', text: product.display_price
      expect(page).to have_content product.description
    end
  end
end
