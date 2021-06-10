require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "display product details" do
    given(:taxonomy) { create(:taxonomy) }
    given(:taxon) { create(:taxon, name: "Taxon", taxonomy: taxonomy, parent: taxonomy.root) }
    given(:product) { create(:product, taxons: [taxon]) }
    given!(:related_products) { create_list(:product, 4, taxons: [taxon]) }

    background { visit potepan_product_path(product.id) }

    scenario "display each product details" do
      expect(page).to have_title "#{product.name} - BIGBAG Store"
      expect(page).to have_selector '.page-title h2', text: product.name
      expect(page).to have_selector '.col-xs-6 li', text: product.name
      expect(page).to have_selector '.media-body h2', text: product.name
      expect(page).to have_selector 'h3', text: product.display_price
      expect(page).to have_content product.description
    end

    scenario 'related products must be displayed' do
      within('.productsContent') do
        related_products.each do |related_product|
          expect(page).to have_selector '.productBox', count: 4
          expect(page).to have_selector '.productBox h5', text: related_product.name
          expect(page).to have_selector '.productBox h3', text: related_product.display_price
          expect(page).to have_link related_product.name
          expect(page).to have_link related_product.display_price
          click_link related_product.name, href: potepan_product_path(related_product.id)
          expect(current_path).to eq potepan_product_path(related_product.id)
          expect(page).to have_http_status(:success)
        end
      end
    end
  end
end
