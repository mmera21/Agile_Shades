# Join model for Product <-> Color. Stores the shade name the brand gives that colour.
class ProductColor < ApplicationRecord
  # RUBRIC 1.5 — many-to-many join model
  belongs_to :product
  belongs_to :color

  # RUBRIC 1.6 — Validations (2+)
  validates :colour_name, presence: true
  validates :color_id, uniqueness: { scope: :product_id }
end
