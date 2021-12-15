json.set! :products do
  json.array! @products do |product|
    json.date product.date
    json.position product.position
    json.name product.name
  end
end