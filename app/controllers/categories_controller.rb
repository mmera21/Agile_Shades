class CategoriesController < ApplicationController
  def index
    @categories = Category.left_joins(:products)
                          .select("categories.*, COUNT(products.id) AS products_count")
                          .group("categories.id")
                          .order(:name)
  end

  # RUBRIC 3.4 — Category show page -> products in that category (one-to-many)
  def show
    @category = Category.find(params[:id])
    @products = @category.products.includes(:brand, :colors).order(:name).page(params[:page]).per(12)
  end
end
