class ModelsController < ApplicationController
  def index
    @models = Model.includes(:brand)
    
    # 검색 기능
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @models = @models.joins(:brand).where(
        "models.name LIKE ? OR brands.name LIKE ?", 
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

  def toggle_favorite
    @model = Model.find(params[:id])
    favorites = session[:favorites]
    favorites = Array(favorites).map(&:to_i)
    if favorites.include?(@model.id)
      favorites.delete(@model.id)
      message = '즐겨찾기에서 제거되었습니다.'
    else
      favorites << @model.id
      message = '즐겨찾기에 추가되었습니다.'
    end
    session[:favorites] = favorites.uniq
    
    respond_to do |format|
      format.html { redirect_back(fallback_location: model_path(@model), notice: message) }
      format.json { render json: { favorited: favorites.include?(@model.id), message: message } }
      format.turbo_stream do
        if request.referer&.include?('/models/favorites')
          # 즐겨찾기 페이지에서 호출된 경우
          render turbo_stream: [
            turbo_stream.update("favorites-container", partial: "models/favorites_list", locals: { models: get_favorites_models }),
            turbo_stream.update("flash-messages", partial: "shared/flash_message", locals: { message: message, type: "success" })
          ]
        else
          # 다른 페이지에서 호출된 경우
          render turbo_stream: [
            turbo_stream.replace("favorite-btn", partial: "models/favorite_button", locals: { model: @model }),
            turbo_stream.update("flash-messages", partial: "shared/flash_message", locals: { message: message, type: "success" })
          ]
        end
      end
    end
  end

  def favorites
    @models = get_favorites_models
  end

  private

  def get_favorites_models
    favorites = []
    models = []
    
    # 실제 세션 데이터가 있다면 사용
    if session[:favorites].is_a?(Array)
      favorites = session[:favorites].select { |id| id.to_s =~ /\A\d+\z/ }.map(&:to_i).uniq
      models = Model.includes(:brand).where(id: favorites).to_a
    end
    
    if params[:sort].present?
      case params[:sort]
      when 'name'
        models = models.sort_by(&:name)
      when 'price'
        models = models.sort_by(&:price)
      when 'newest'
        models = models.sort_by(&:year).reverse
      end
    else
      models = models.sort_by(&:created_at).reverse
    end
    
    models
  end
end
