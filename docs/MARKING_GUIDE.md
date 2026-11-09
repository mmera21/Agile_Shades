# Marking guide — features to demo

Search the project for `RUBRIC <number>` in VS Code (Ctrl+Shift+F) to jump straight to the code.

| # | Feature | Marks | Where to show it |
|---|---------|-------|------------------|
| 1.1 (required) | Describe Datasets | 3 | `README.md` + About page (`app/views/pages/about.html.erb`) |
| 1.2 | Database ERD | 5 | `docs/erd.png` / `app/assets/images/erd.svg`, shown on the About page |
| 1.3 | 4+ AR Models | 8 | `app/models/` — Brand, Category, Product, Tag, ProductTag, Color, ProductColor, Review; migrations in `db/migrate/` |
| 1.4 (required) | At least 1 association | 3 | `app/models/brand.rb` (`has_many :products`) + `product.rb` (`belongs_to :brand`) |
| 1.5 | Two or more many-to-many | 8 | `app/models/product.rb`: `has_many :tags, through: :product_tags` and `has_many :colors, through: :product_colors` (used on product, tag and color show pages) |
| 1.6 | Validations (2+ on every model) | 5 | every file in `app/models/` (search `RUBRIC 1.6`) |
| 1.7 | 3+ data sources, 200+ rows | 8 | `db/seeds.rb` — eyeshadow endpoint, eyeliner endpoint, Faker. Run `bin/rails db:seed`: it prints the row count of each table |
| 2.1 | About page | 3 | menu → About |
| 2.2 | Menu on all pages | 5 | `app/views/shared/_navbar.html.erb`, rendered in `layouts/application.html.erb` |
| 3.1 (required) | Collection navigation | 3 | menu → Products |
| 3.2 | Member pages | 5 | click any product → `products/show.html.erb` shows every column |
| 3.3 | Multi-model data on member pages | 5 | product page shows brand, category, tags, shades (colors) and reviews |
| 3.4 | Hierarchical navigation | 8 | Brands → brand → product → click brand again (same for Categories, Tags, and the shade swatches → Color page) |
| 3.5 | Pagination | 5 | Products list (12 per page) — kaminari, `app/views/kaminari/` |
| 3.6 | Mapping | 8 | Not possible — this dataset has no locations |
| 4.1 (required) | Simple search | 3 | search box in the menu or on the Products page (`ProductsController#index`) |
| 4.2 | Hierarchical search | 5 | Category dropdown in the search form (`shared/_search_form.html.erb`) |
| 5.1 (required) | Valid HTML | 3 | paste "View source" of each page into https://validator.w3.org/#validate_by_input |
| 5.2 | ERB conditional | 3 | `products/show.html.erb` (`if @product.tags.any?`), `products/index.html.erb`, `_navbar.html.erb` |
| 5.3 | Bootstrap grid | 5 | `.container/.row/.col-*` in every view; Bootstrap 5 loaded in the layout |
| 6.1 (required) | Git + GitHub | 3 | `git remote -v` + `git push origin main` |
| 6.2 | 20 commits | 3 | `git log --oneline` |

**Max without mapping: 92 / 100** (before the 1.2 bonus for Week 9).
