# RUBRIC 1.3 — AR Models / tables (Color = a unique hex shade)
class CreateColors < ActiveRecord::Migration[7.2]
  def change
    create_table :colors do |t|
      t.string :hex_value, null: false
      t.timestamps
    end
    add_index :colors, :hex_value, unique: true
  end
end
