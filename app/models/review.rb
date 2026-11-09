# Fake customer reviews generated with the Faker gem
class Review < ApplicationRecord
  # RUBRIC 1.5 — one-to-many (belongs_to side): Review * ── 1 Product
  belongs_to :product

  # RUBRIC 1.6 — Validations (2+)
  validates :reviewer_name, presence: true
  validates :stars, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true, length: { minimum: 10 }
end
