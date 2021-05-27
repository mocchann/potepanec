require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  let(:taxonomy) { create(:taxonomy) }
  let!(:product) { create(:product, taxons: [taxon]) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }

  before do
    get potepan_category_path(taxon.id)
  end

  it 'リクエストが成功する' do
    expect(response.status).to eq 200
  end

  it 'taxon名、product名、taxonomy名が表示される' do
    expect(response.body).to include taxon.name
    expect(response.body).to include product.name
    expect(response.body).to include taxonomy.name
  end
end
