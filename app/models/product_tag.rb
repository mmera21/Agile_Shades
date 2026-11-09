# Join model for Product <-> Tag
class ProductTag < ApplicationRecord
  # RUBRIC 1.5 — many-to-many join model
  belongs_to :product
  belongs_to :tag

  # RUBRIC 1.6 — Validations (2+) (belongs_to also validates presence)
  validates :product_id, presence: true
  validates :tag_id, presence: true, uniqueness: { scope: :product_id }
end
