require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "display product details" do
    given(:taxon) { create(:taxon) }
    given(:product) { create(:product, taxons: [taxon]) }

    background { visit potepan_product_path(product.id) }

    scenario "display each product details" do
      expect(page).to have_title "#{product.name} - BIGBAG Store"
      expect(page).to have_selector '.page-title h2', text: product.name
      expect(page).to have_selector '.col-xs-6 li', text: product.name
      expect(page).to have_selector '.media-body h2', text: product.name
      expect(page).to have_selector 'h3', text: product.display_price
      expect(page).to have_content product.description
    end
  end
end
