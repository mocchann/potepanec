require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "#show" do
    let(:product) { create(:product) }

    before do
      get :show, params: { id: product.id }
    end

    scenario "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    scenario "assigns @product" do
      expect(assigns(:product)).to eq product
    end

    scenario "render show page" do
      expect(response).to render_template "potepan/products/show"
    end
  end
end
