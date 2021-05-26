require 'rails_helper'
require 'spree/testing_support/factories'

include ApplicationHelper
RSpec.describe ApplicationHelper, type: :helper do
  describe 'ページタイトル' do
    context '@product.nameが空白' do
      it 'base_titleだけが表示' do
        expect(helper.full_title('')).to eq('BIGBAG Store')
      end
    end

    context '@product.nameがnil' do
      it 'base_titleだけが表示' do
        expect(helper.full_title(nil)).to eq('BIGBAG Store')
      end
    end

    context '@product.nameに値が入っている' do
      it 'base_titleと@product.nameが表示' do
        expect(helper.full_title('Tote')).to eq('Tote - BIGBAG Store')
      end
    end
  end
end
