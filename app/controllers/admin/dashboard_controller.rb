class Admin::DashboardController < ApplicationController
  def show
    @product = Product
    @category = Category
  end
end
