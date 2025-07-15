class BrandsController < ApplicationController
  def index
    @brands = Brand.includes(:models)
    
    # 검색 기능
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @brands = @brands.where(
        "name ILIKE ? OR country ILIKE ?", 
        search_term, search_term
      )
    end
    
    # 카테고리 필터
    if params[:category].present?
      @brands = @brands.where(category: params[:category])
    end
    
    # 국가 필터
    if params[:country].present?
      @brands = @brands.where(country: params[:country])
    end
    
    # 설립 연도 범위 필터
    if params[:founded_from].present?
      @brands = @brands.where("founded_year >= ?", params[:founded_from])
    end
    
    if params[:founded_to].present?
      @brands = @brands.where("founded_year <= ?", params[:founded_to])
    end
    
    # 정렬
    case params[:sort]
    when 'name'
      @brands = @brands.order(:name)
    when 'founded'
      @brands = @brands.order(:founded_year)
    when 'newest'
      @brands = @brands.order(created_at: :desc)
    else
      @brands = @brands.order(:name)
    end
    
    # 페이지네이션
    @brands = @brands.page(params[:page]).per(12)
  end

  def show
    @brand = Brand.includes(:models).find(params[:id])
    @models = @brand.models.order(:name).page(params[:page]).per(12)
  end
end
