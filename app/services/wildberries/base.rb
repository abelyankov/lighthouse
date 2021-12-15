class Wildberries::Base
  require 'faraday_middleware'

  BASE_API_URL = "https://napi.wildberries.ru/api/"

  def initialize(args={})
    args.each do |name, value|
      attr_name = name.to_s.underscore
      send("#{attr_name}=", value) if respond_to?("#{attr_name}=")
    end
  end

  def self.faraday
    Faraday.new do |f|
      f.request :retry, max: 2
      f.request :json
      f.response :json
      f.response :raise_error
    end
  end
end