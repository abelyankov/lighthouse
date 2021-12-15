class Sync
  def initialize(date: Date.today)
    @words = ["GILLETTE", "Bruder", "Medical technology", "ECCO", "Играем вместе"]
    @date = date
  end

  def call
    @words.each do |word|
      fetch_products(search: word)
    end
  end

  private

  def fetch_products(search:, page: 1)
    p "Started fetching products for '#{search}' at #{Time.now}."
    result = Wildberries::Search.result(search: search, page: page)
    raise StandardError.new(result.error) if result.error
    save_products(products: result.products, word: search)
    sleep(2) # we sleep for 2 seconds, because wildberries api prevent spamming.
    fetch_products(search: search, page: page+1) if result.pager.total_pages > page
  end

  def save_products(products:[], word:)
    products.each do |product|
      product = Product.new(wildberries_id: product.id, name: word, date: @date, position: product.position)
      Rails.logger.info product.errors.map(&:message).join("\n\n") unless product.save
    end
  end
end