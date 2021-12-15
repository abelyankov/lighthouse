module Wildberries
  class Search < Base
    attr_accessor :products, :pager, :error

    def self.result(search:, page:1)
      begin
        products = []
        pager = nil
        error = nil
        response = Wildberries::Base.faraday.get(BASE_API_URL + "search/results") do |request|
          request.params = {search: search, page: page}
        end
      rescue Faraday::ClientError => e
        error = e.response[:body]
      else
        error = response.body.dig("data", "errorMsg")
        pager = Wildberries::Page.new(response.body.dig("data", "pager")) if response.body.dig("data", "pager")

        if response.body.dig("data", "products").present?
          response.body.dig("data", "products").each_with_index do |product, index|
            index += 1
            # here we set hardcode number, because I can't find the param to set page size
            position = page > 1 ? index+((page-1)*110) : index
            products.push Wildberries::Product.new(id: product, position: position)
          end
        end
      end
      Wildberries::Search.new(products: products, pager: pager, error: error)
    end
  end
end