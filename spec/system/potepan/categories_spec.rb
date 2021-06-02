require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  let(:taxonomy) { create(:taxonomy, name: 'Categories') }
  let(:product) { create(:product, name: 'tote', taxon_ids: taxon.id) }
  let(:taxon) { create(:taxon, name: 'Bag', taxonomy_id: taxonomy, parent_id: taxonomy) }
  let(:product1) { create(:product, name: 'shirts', taxon_ids: taxon.id) }

  before do
    driven_by :selenium, using: :selenium_chrome_headless
    visit potepan_category_path(product.taxons.first.id)
  end

  it 'カテゴリー名をクリックで、カテゴリーごとの商品一覧ページが表示される' do
    click_on taxonomy.name
    expect(current_path).to eq potepan_category_path(taxon.id)
  end

  it 'categoriesをクリックで、カテゴリー名が表示される' do
    click_on taxonomy.name
    expect(page).to have_content taxon.name
  end

  it '商品名をクリックで、商品詳細ページが表示される' do
    click_on 'tote'
    expect(current_path).to eq potepan_product_path(product.id)
  end

  it '一覧ページへ戻るをクリックで、商品が属するカテゴリー一覧へ戻る' do
    visit potepan_product_path(product.id)
    find('.fa-reply').click
    expect(current_path).to eq potepan_product_path(product.id)
  end

  it '選択されたtaxonに紐づく商品が表示される' do
    click_on taxonomy.name
    first('li').click_link
    expect(current_path).to eq potepan_category_path(taxon.id)
    expect(page).to have_content product.name
  end

  it '選択されたtaxonに紐付かない商品は表示されない' do
    click_on taxonomy.name
    first('li').click_link
    expect(current_path).to eq potepan_category_path(taxon.id)
    expect(page).not_to have_content product1.name
  end
end
