require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:product) { create(:product, name: 'tote', taxon_ids: taxon.id) }
  let(:taxon) { create(:taxon, taxonomy_id: taxonomy, parent_id: taxonomy) }

  before do
    driven_by(:rack_test)
    visit potepan_category_path(taxon.id)
  end

  it 'カテゴリー名をクリックで、カテゴリーごとの商品一覧ページが表示される' do
    click_on taxonomy.name
    expect(current_path).to eq potepan_category_path(taxon.id)
  end

  it 'categoriesをクリックで、カテゴリー名が表示される' do
    click_on taxonomy.name
    expect(page).to have_content taxon.name
  end
end
