require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe 'Potepan::Products', type: :system do
  let(:product) { create(:product) }

  before do
    driven_by(:rack_test)
    visit potepan_product_path(product.id)
  end
  
  it '商品ページに商品名、料金、商品詳細が表示される' do
    expect(page).to have_css ".productSlider" do
      expect(page).to have_content product.name
      expect(page).to have_content product.description
      expect(page).to have_content product.display_price.to_s
    end
  end

end
