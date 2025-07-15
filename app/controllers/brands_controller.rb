class BrandsController < ApplicationController
  def index
    @brands = Brand.all
    
    # 검색 기능
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @brands = @brands.where("name LIKE ? OR country LIKE ?", search_term, search_term)
    end
    
    # 국가 필터
    if params[:country].present?
      @brands = @brands.where(country: params[:country])
    end
    
    # 정렬
    case params[:sort]
    when 'name'
      @brands = @brands.order(:name)
    when 'newest'
      @brands = @brands.order(founded_year: :desc)
    when 'popular'
      @brands = @brands.joins(:models).group('brands.id').order('COUNT(models.id) DESC')
    else
      @brands = @brands.order(created_at: :desc)
    end
    
    # 페이지네이션
    @brands = @brands.page(params[:page]).per(12)
  end

  def show
    @brand = Brand.find(params[:id])
    @models = @brand.models
    
    # 정렬
    case params[:sort]
    when 'newest'
      @models = @models.order(year: :desc)
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
end
