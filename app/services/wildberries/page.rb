module Wildberries
  class Page < Base
    attr_accessor :current_page, :total_items, :total_pages, :page_size
  end
end