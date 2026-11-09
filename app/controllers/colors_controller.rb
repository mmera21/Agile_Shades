class ColorsController < ApplicationController
  # RUBRIC 3.4 — Color show page -> every product that has this exact shade (many-to-many)
  def show
    @color          = Color.find(params[:id])
    @product_colors = @color.product_colors.includes(product: :brand).order(:colour_name)
  end
end
