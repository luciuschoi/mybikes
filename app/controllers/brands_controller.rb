class BrandsController < ApplicationController
  before_action :set_brand, only: [:show]
  
  def index
    @brands = Brand.all.order(:name)
    @brands = @brands.where(category: params[:category]) if params[:category].present?
    @brands = @brands.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @models = @brand.models.order(:name)
  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end
end
