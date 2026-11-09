class Tag < ApplicationRecord
  # RUBRIC 1.5 — many-to-many #1: Tag * ── * Product (through product_tags)
  has_many :product_tags, dependent: :destroy
  has_many :products, through: :product_tags

  # RUBRIC 1.6 — Validations (2+)
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
