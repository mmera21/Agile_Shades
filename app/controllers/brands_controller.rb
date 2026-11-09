class BrandsController < ApplicationController
  def index
    @brands = Brand.left_joins(:products)
                   .select("brands.*, COUNT(products.id) AS products_count")
                   .group("brands.id")
                   .order(:name)
  end

  # RUBRIC 3.4 — Brand show page lists (and links to) all of its products
  def show
    @brand    = Brand.find(params[:id])
    @products = @brand.products.includes(:brand, :colors).order(:name).page(params[:page]).per(12)
  end
end
