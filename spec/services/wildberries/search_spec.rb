require 'rails_helper'

describe 'Wildberries::Search' do
  let(:wildberries_search_result) { Wildberries::Search.result(search: "Macbook") }

  context "send search request" do
    it 'should return data correctly' do
      expect(wildberries_search_result).to respond_to :products
      expect(wildberries_search_result).to respond_to :pager
      expect(wildberries_search_result).to respond_to :error
    end

    it 'should parse correct data' do
      service = Wildberries::Search.result(search: nil,page: 1)
      expect(service.error).to eq("По Вашему запросу \"\" ничего не найдено.")

      service = Wildberries::Search.result(search: "macbook")
      expect(service.products.size).to eq 110

      service = Wildberries::Search.result(search: "macbook", page: 18)
      expect(service.error).to eq("По Вашему запросу \"macbook\" ничего не найдено.")
    end

    it 'should correctly set index to products' do
      service = Wildberries::Search.result(search: 'macbook', page: 1).products.last.position
      service_page_2 = Wildberries::Search.result(search: 'macbook', page: 2).products.first.position
      service_page_3 = Wildberries::Search.result(search: 'macbook', page: 3).products.first.position

      expect(service).to eq 110
      expect(service_page_2).to eq 111
      expect(service_page_3).to eq 221
    end
  end
end