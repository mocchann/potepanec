RSpec.describe Spree::ProductDecorator, type: :model do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, name: "Taxon", taxonomy: taxonomy, parent: taxonomy.root) }
  let(:taxon_unrelated) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:product_unrelated) { create(:product, taxons: [taxon_unrelated]) }
  let!(:related_products) { create_list(:product, 4, taxons: [taxon]) }

  it 'no unrelated products are included' do
    expect(product.related_products).not_to include product_unrelated.taxons
  end

  it 'no duplicate products are displayed' do
    expect(product.related_products).not_to include product
  end
end
