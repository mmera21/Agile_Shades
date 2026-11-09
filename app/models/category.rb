class Category < ApplicationRecord
  # RUBRIC 1.5 — one-to-many: a Category has many Products
  has_many :products, dependent: :destroy

  # RUBRIC 1.6 — Validations (2+)
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 50 }

  def display_name
    name.titleize
  end
end
