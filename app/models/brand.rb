class Brand < ApplicationRecord
  # RUBRIC 1.4 / 1.5 — one-to-many: a Brand has many Products
  has_many :products, dependent: :destroy

  # RUBRIC 1.6 — Validations (2+)
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, length: { maximum: 100 }

  # Names come lowercase from the API ("covergirl") -> nicer for display
  def display_name
    name.titleize
  end
end
