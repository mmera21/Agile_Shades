class Product < ApplicationRecord
  # RUBRIC 1.4 / 1.5 — one-to-many (belongs_to side)
  belongs_to :brand
  belongs_to :category

  # RUBRIC 1.5 — one-to-many: Product 1 ── * Review (Faker data)
  has_many :reviews, dependent: :destroy

  # RUBRIC 1.5 — many-to-many #1: Product * ── * Tag
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags

  # RUBRIC 1.5 — many-to-many #2: Product * ── * Color
  has_many :product_colors, dependent: :destroy
  has_many :colors, through: :product_colors

  # RUBRIC 1.6 — Validations (2+)
  validates :name, presence: true
  validates :product_type, presence: true
  validates :api_id, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :rating, numericality: { in: 0..5 }, allow_nil: true

  # Average of the (Faker) review stars, used on the show page
  def average_stars
    return nil if reviews.empty?

    (reviews.sum(&:stars).to_f / reviews.size).round(1)
  end

  def formatted_price
    return "Price not listed" if price.blank? || price.zero?

    "#{price_sign.presence || '$'}#{format('%.2f', price)} #{currency}".strip
  end
end
