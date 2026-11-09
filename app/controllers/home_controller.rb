class HomeController < ApplicationController
  def index
    @product_count = Product.count
    @brand_count   = Brand.count
    @color_count   = Color.count
    @review_count  = Review.count
    @categories    = Category.order(:name)
    @swatches      = Color.order(Arel.sql("RANDOM()")).limit(48)
    @featured      = Product.includes(:brand, :colors).order(Arel.sql("RANDOM()")).limit(4)
  end
end
