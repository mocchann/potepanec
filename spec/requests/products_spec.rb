require 'rails_helper'

RSpec.describe 'Potepan::Products', type: :request do
  describe "#show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxon_ids: taxon.id) }

    before do
      get potepan_product_path(product.id)
    end

    it "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq product
    end

    it "render show page" do
      expect(response).to render_template "potepan/products/show"
    end
  end
end
