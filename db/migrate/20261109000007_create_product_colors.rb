# RUBRIC 1.3 — join table (with its own extra column: colour_name)
# RUBRIC 1.5 — many-to-many #2: Product * ── * Color (through product_colors)
class CreateProductColors < ActiveRecord::Migration[7.2]
  def change
    create_table :product_colors do |t|
      t.references :product, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.string :colour_name, null: false
      t.timestamps
    end
    add_index :product_colors, [:product_id, :color_id], unique: true
  end
end
