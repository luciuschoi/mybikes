class ModelsController < ApplicationController
  before_action :set_model, only: [:show]
  
  def index
    @models = Model.includes(:brand).all.order(:name)
    @models = @models.where(category: params[:category]) if params[:category].present?
    @models = @models.where(brand_id: params[:brand_id]) if params[:brand_id].present?
    @models = @models.where("models.name LIKE ? OR brands.name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @models = @models.by_price_range(params[:min_price], params[:max_price]) if params[:min_price].present? && params[:max_price].present?
  end

  def show
    @related_models = Model.where(category: @model.category).where.not(id: @model.id).limit(3)
  end

  private

  def set_model
    @model = Model.includes(:brand).find(params[:id])
  end
end
