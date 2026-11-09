# =============================================================================
# RUBRIC 1.7 — Data Sources (3 sources -> 8 marks)
#   Source 1: Makeup API endpoint  ?product_type=eyeshadow   (JSON)
#   Source 2: Makeup API endpoint  ?product_type=eyeliner    (JSON)
#             (the project doc says multiple endpoints of the same API count
#              as separate data sources)
#   Source 3: Faker gem -> fake customer Reviews for every product
#
# RUBRIC 1.7 — 200+ rows total. At the end this script prints the row
#   count of every table so you can show it in the demo.
#
# Run with:  rails db:seed      (or  rails db:reset  to drop + recreate + seed)
# =============================================================================
require "net/http"
require "json"

API_BASE      = "https://makeup-api.herokuapp.com/api/v1/products.json".freeze
PRODUCT_TYPES = %w[eyeshadow eyeliner].freeze

# Download one endpoint and return an Array of product hashes
def fetch_products(product_type)
  uri = URI("#{API_BASE}?product_type=#{product_type}")
  puts "Downloading #{uri} ..."

  response = Net::HTTP.start(uri.host, uri.port, use_ssl: true,
                                                 open_timeout: 30, read_timeout: 120) do |http|
    http.get(uri.request_uri)
  end
  raise "API error #{response.code} for #{product_type}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

# The API gives images like "//s3.amazonaws.com/..." -> make them https
def clean_url(url)
  return nil if url.blank?

  url.start_with?("//") ? "https:#{url}" : url
end

# --- Start fresh (children first because of foreign keys) -------------------
puts "Clearing old data..."
ProductColor.delete_all
ProductTag.delete_all
Review.delete_all
Product.delete_all
Color.delete_all
Tag.delete_all
Category.delete_all
Brand.delete_all

# --- Sources 1 & 2: Makeup API ----------------------------------------------
PRODUCT_TYPES.each do |product_type|
  fetch_products(product_type).each do |item|
    next if item["name"].blank?

    brand    = Brand.find_or_create_by!(name: (item["brand"].presence || "unknown brand").strip.downcase)
    category = Category.find_or_create_by!(name: (item["category"].presence || "uncategorized").strip.downcase)

    # We keep the API id in api_id, but let ActiveRecord create our own primary keys
    product = Product.find_or_initialize_by(api_id: item["id"])
    product.assign_attributes(
      name:         item["name"].strip,
      price:        item["price"].presence&.to_d,
      price_sign:   item["price_sign"],
      currency:     item["currency"],
      rating:       item["rating"],
      product_type: item["product_type"].presence || product_type,
      description:  ActionController::Base.helpers.strip_tags(item["description"].to_s).squish,
      image_url:    clean_url(item["api_featured_image"]) || clean_url(item["image_link"]),
      product_link: item["product_link"],
      website_link: item["website_link"],
      brand:        brand,
      category:     category
    )

    # Validations can stop a record from saving -> print why (Appendix A tip)
    unless product.save
      puts "  Skipped '#{item['name']}': #{product.errors.full_messages.join(', ')}"
      next
    end

    # Many-to-many #1: tags
    Array(item["tag_list"]).each do |tag_name|
      next if tag_name.blank?

      tag = Tag.find_or_create_by!(name: tag_name.strip)
      ProductTag.find_or_create_by!(product: product, tag: tag)
    end

    # Many-to-many #2: colours (one Color row per unique hex, shared across products)
    Array(item["product_colors"]).each do |shade|
      hex = shade["hex_value"].to_s.strip.downcase
      next unless hex.match?(Color::HEX_FORMAT)

      color = Color.find_or_create_by!(hex_value: hex)
      ProductColor.find_or_create_by!(product: product, color: color) do |pc|
        pc.colour_name = shade["colour_name"].to_s.strip.presence || hex
      end
    end
  end
end

# --- Source 3: Faker reviews -------------------------------------------------
puts "Creating fake reviews with Faker..."
Product.find_each do |product|
  rand(1..4).times do
    product.reviews.create!(
      reviewer_name: Faker::Name.name,
      stars:         rand(1..5),
      body:          Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 2),
      reviewed_on:   Faker::Date.backward(days: 365)
    )
  end
end

# --- Row counts (show this during marking for the 200+ rows requirement) -----
counts = {
  "Brands"         => Brand.count,
  "Categories"     => Category.count,
  "Tags"           => Tag.count,
  "Colors"         => Color.count,
  "Products"       => Product.count,
  "Product tags"   => ProductTag.count,
  "Product colors" => ProductColor.count,
  "Reviews"        => Review.count
}
puts "\n==== Seed complete ===="
counts.each { |table, total| puts "#{table.ljust(16)} #{total}" }
puts "TOTAL ROWS       #{counts.values.sum}"
