require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, name: "Taxon", taxonomy: taxonomy, parent: taxonomy.root) }
  let(:product) { create(:product, taxons: [taxon]) }

  before do
    get potepan_product_path(product.id)
  end

  it 'Success response is received' do
    expect(response).to be_success
  end

  it 'Success display the product detail screen' do
    expect(response).to have_http_status(200)
  end

  it 'product name must be included' do
    expect(response.body).to include product.name
  end

  it 'contains the product price' do
    expect(response.body).to include product.display_price.to_s
  end

  it 'contains the product content' do
    expect(response.body).to include product.description
  end
end
