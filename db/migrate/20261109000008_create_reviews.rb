# RUBRIC 1.3 — table for related FAKE data (Faker gem)
# RUBRIC 1.5 — one-to-many: Product 1 ── * Review
class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.string  :reviewer_name, null: false
      t.integer :stars, null: false
      t.text    :body, null: false
      t.date    :reviewed_on
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
