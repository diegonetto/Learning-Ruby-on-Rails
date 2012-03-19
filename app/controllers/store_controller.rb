class StoreController < ApplicationController
  def index
    if session[:counter].nil?
      session[:counter] = 1
    end
    session[:counter] += 1
    @counter = session[:counter]
    @products = Product.order(:title)
    @cart = current_cart
  end
end
