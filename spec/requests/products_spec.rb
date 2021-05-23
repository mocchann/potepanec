require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe 'Potepan::Products', type: :request do
  let(:product) { FactoryBot.create(:product) }
  let!(:related_products) { FactoryBot.create_list(:product, 5, name: 'testitem') }

  before do
    get potepan_product_path(product.id)
  end

  describe 'GET /show' do
    it 'リクエストが成功する' do
      expect(response.status).to eq 200
    end

    it '@productに値が入っている' do
      expect(assigns(:product)).to eq product
    end

    it 'httpアクセスの成功' do
      expect(response).to have_http_status(:success)
    end
  end
end
