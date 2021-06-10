class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCT_COUNT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @taxons = @product.taxons
    @related_products = @product.related_products.limit(MAX_RELATED_PRODUCT_COUNT)
  end
end
