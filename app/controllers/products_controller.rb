class ProductsController < ApplicationController
  def show
    @products = Product.by_wildberries_id(params[:id])
  end
end