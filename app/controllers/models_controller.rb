class ModelsController < ApplicationController
  def index
    @models = Model.includes(:brand)
    
    # 검색 기능
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @models = @models.joins(:brand).where(
        "models.name ILIKE ? OR brands.name ILIKE ?", 
        search_term, search_term
      )
    end
    
    # 카테고리 필터
    if params[:category].present?
      @models = @models.where(category: params[:category])
    end
    
    # 브랜드 필터
    if params[:brand_id].present?
      @models = @models.where(brand_id: params[:brand_id])
    end
    
    # 연도 범위 필터
    if params[:year_from].present?
      @models = @models.where("year >= ?", params[:year_from])
    end
    
    if params[:year_to].present?
      @models = @models.where("year <= ?", params[:year_to])
    end
    
    # 가격 범위 필터
    if params[:price_from].present?
      @models = @models.where("price >= ?", params[:price_from])
    end
    
    if params[:price_to].present?
      @models = @models.where("price <= ?", params[:price_to])
    end
    
    # 정렬
    case params[:sort]
    when 'newest'
      @models = @models.order(year: :desc, created_at: :desc)
    when 'price'
      @models = @models.order(:price)
    when 'name'
      @models = @models.order(:name)
    else
      @models = @models.order(created_at: :desc)
    end
    
    # 페이지네이션
    @models = @models.page(params[:page]).per(12)
  end

  def show
    @model = Model.includes(:brand).find(params[:id])
    @related_models = Model.where(brand: @model.brand)
                          .where.not(id: @model.id)
                          .limit(4)
  end
end
