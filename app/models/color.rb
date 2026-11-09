class Color < ApplicationRecord
  HEX_FORMAT = /\A#[0-9a-f]{3}([0-9a-f]{3})?\z/

  # RUBRIC 1.5 — many-to-many #2: Color * ── * Product (through product_colors)
  has_many :product_colors, dependent: :destroy
  has_many :products, through: :product_colors

  # RUBRIC 1.6 — Validations (2+)
  validates :hex_value, presence: true
  validates :hex_value, uniqueness: true
  validates :hex_value, format: { with: HEX_FORMAT, message: "must look like #a1b2c3" }
end
