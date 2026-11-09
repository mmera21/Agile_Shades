class ProductsController < ApplicationController
  # RUBRIC 3.1 — Collection navigation: list of ALL products
  # RUBRIC 4.1 — Simple search: text search with params[:q]
  # RUBRIC 4.2 — Hierarchical search: restrict to a Category (dropdown -> params[:category_id])
  # RUBRIC 3.5 — Pagination with kaminari (.page / .per)
  def index
    @categories = Category.order(:name)
    @products   = Product.joins(:brand).includes(:brand, :category, :colors).order(:name)

    if params[:q].present?
      term = "%#{Product.sanitize_sql_like(params[:q].strip)}%"
      @products = @products.where(
        "products.name LIKE :term OR products.description LIKE :term OR brands.name LIKE :term",
        term: term
      )
    end

    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?

    @products = @products.page(params[:page]).per(12)
  end

  # RUBRIC 3.2 — Member page for one product
  # RUBRIC 3.3 — loads data from associated models (brand, category, tags, colors, reviews)
  def show
    @product = Product.includes(:brand, :category, :tags, :reviews, product_colors: :color)
                      .find(params[:id])
  end
end
