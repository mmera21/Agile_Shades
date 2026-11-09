# RUBRIC 1.3 — AR Models / tables (Product — main table)
# RUBRIC 1.4 / 1.5 — foreign keys for the one-to-many associations:
#    Brand 1 ── * Product   and   Category 1 ── * Product
class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.integer :api_id, null: false          # id from the Makeup API (we do NOT reuse it as our PK)
      t.string  :name, null: false
      t.decimal :price, precision: 8, scale: 2
      t.string  :price_sign
      t.string  :currency
      t.decimal :rating, precision: 3, scale: 1
      t.string  :product_type, null: false    # "product_type", not "type" (reserved word)
      t.text    :description
      t.string  :image_url
      t.string  :product_link
      t.string  :website_link
      t.references :brand, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
    add_index :products, :api_id, unique: true
  end
end
