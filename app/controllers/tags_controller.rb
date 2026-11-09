class TagsController < ApplicationController
  def index
    @tags = Tag.left_joins(:product_tags)
               .select("tags.*, COUNT(product_tags.id) AS products_count")
               .group("tags.id")
               .order(:name)
  end

  # RUBRIC 3.4 — Tag show page -> products with that tag (many-to-many)
  def show
    @tag      = Tag.find(params[:id])
    @products = @tag.products.includes(:brand, :colors).order(:name).page(params[:page]).per(12)
  end
end
