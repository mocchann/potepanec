require 'rails_helper'

RSpec.describe 'Potepan::Categories', type: :request do
  describe "#show" do
    let!(:taxonomy) { create(:taxonomy) }
    let!(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:taxon_child) { create(:taxon, taxonomy: taxonomy, parent: taxon) }
    let!(:product1) { create(:product, name: "correct product", taxons: [taxon_child]) }
    let!(:product2) { create(:product, name: "incorrect product") }

    before do
      get potepan_category_path(taxon_child.id)
    end

    it "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end

    it "render show page" do
      expect(response).to render_template :show
    end

    it "assigns taxonomies" do
      expect(assigns(:taxonomies)).to include(taxonomy)
    end

    it "assigns taxon" do
      expect(assigns(:taxon)).to eq(taxon_child)
    end

    it "assigns correct product" do
      expect(assigns(:products)).to match_array(product1)
    end
  end
end
