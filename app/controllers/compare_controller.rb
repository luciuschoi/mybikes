class CompareController < ApplicationController
  def index
    @compare_list = session[:compare_list] || []
    @models = Model.includes(:brand).where(id: @compare_list)
  end

  def add
    model_id = params[:id].to_i
    compare_list = session[:compare_list] || []
    
    if compare_list.length >= 2
      redirect_back(fallback_location: models_path, alert: '최대 2개 모델만 비교할 수 있습니다.')
      return
    end
    
    unless compare_list.include?(model_id)
      compare_list << model_id
      session[:compare_list] = compare_list
      redirect_back(fallback_location: models_path, notice: '비교 목록에 추가되었습니다.')
    else
      redirect_back(fallback_location: models_path, alert: '이미 비교 목록에 있습니다.')
    end
  end

  def remove
    model_id = params[:id].to_i
    compare_list = session[:compare_list] || []
    compare_list.delete(model_id)
    session[:compare_list] = compare_list
    
    # Turbo 응답 처리
    respond_to do |format|
      format.html { redirect_back(fallback_location: compare_path, notice: '비교 목록에서 제거되었습니다.') }
      format.turbo_stream { 
        @compare_list = session[:compare_list] || []
        @models = Model.includes(:brand).where(id: @compare_list)
        render turbo_stream: turbo_stream.replace("compare_content", partial: "compare/index")
      }
    end
  end

  def clear
    session[:compare_list] = []
    
    # Turbo 응답 처리
    respond_to do |format|
      format.html { redirect_to compare_path, notice: '비교 목록이 초기화되었습니다.' }
      format.turbo_stream { 
        @compare_list = session[:compare_list] || []
        @models = Model.includes(:brand).where(id: @compare_list)
        render turbo_stream: turbo_stream.replace("compare_content", partial: "compare/index")
      }
    end
  end
end
