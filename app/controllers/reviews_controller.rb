class ReviewsController < ApplicationController
  before_action :set_login


  def create
    @user = current_user
    @review = @user.reviews.new(review_params)
    @product = Product.find params[:product_id]
    @review.product = @product

    if @review.save
      puts "saved"
      redirect_to @product, notice: "saved"
    else
      redirect_to @product, notice:"unsuccessful"
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to @review.product, notice: "deleted"
  end



  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end

  def set_login
    if !current_user
      redirect_to @product, notice: "Login first!"
    end
  end

end