require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "shouldn't save product without name, position, date and wildberries_id" do
    product = Product.new
    assert_not product.save
  end

  test "should save product with name, position, date and wildberries_id" do
    product = Product.new(name: "Test", position: rand(10), date: Date.today, wildberries_id: rand(10))
    assert product.save
  end

  test "should save one product with wildberries_id per day" do
    wildberries_id = rand(10)
    Product.create(name: "Test", position: rand(10), date: Date.today, wildberries_id: wildberries_id)
    Product.create(name: "Test", position: rand(10), date: Date.today, wildberries_id: wildberries_id)
    products = Product.by_wildberries_id(wildberries_id)
    assert_equal 1, products.size
  end

  test "should save two products with different dates" do
    wildberries_id = rand(10)
    Product.create(name: "Test", position: rand(10), date: Date.today, wildberries_id: wildberries_id)
    Product.create(name: "Test", position: rand(10), date: Date.tomorrow, wildberries_id: wildberries_id)
    products = Product.by_wildberries_id(wildberries_id)
    assert_equal 2, products.size
  end
end