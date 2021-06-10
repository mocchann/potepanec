require 'rails_helper'

RSpec.describe 'Potepan::Categories', type: :request do
  describe "#show" do
    let!(:taxonomy) { create(:taxonomy) }
    let!(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:taxon_child) { create(:taxon, taxonomy: taxonomy, parent: taxon) }

    before do
      get potepan_category_path(taxon_child.id)
    end

    it "responds successfully" do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end
  end
end
