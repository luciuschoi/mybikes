require "test_helper"

class ModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = brands(:honda)
    @model = models(:cbr1000rr)
  end

  test "should get index" do
    get models_url
    assert_response :success
    assert_select "h1", "모델"
  end

  test "should get show" do
    get model_url(@model)
    assert_response :success
    assert_select "h1", @model.name
  end

  test "should filter models by search" do
    get models_url, params: { search: "CBR" }
    assert_response :success
    assert_select ".model-card", minimum: 1
  end

  test "should filter models by category" do
    get models_url, params: { category: "motorcycle" }
    assert_response :success
    assert_select ".model-card", minimum: 1
  end

  test "should filter models by brand" do
    get models_url, params: { brand_id: @brand.id }
    assert_response :success
    assert_select ".model-card", minimum: 1
  end

  test "should sort models by price" do
    get models_url, params: { sort: "price" }
    assert_response :success
  end

  test "should sort models by name" do
    get models_url, params: { sort: "name" }
    assert_response :success
  end

  test "should sort models by newest" do
    get models_url, params: { sort: "newest" }
    assert_response :success
  end

  test "should get favorites" do
    get favorites_models_url
    assert_response :success
    assert_select "h1", "즐겨찾기"
  end

  test "should toggle favorite" do
    post toggle_favorite_model_url(@model)
    assert_response :success
    
    # JSON 응답 확인
    json_response = JSON.parse(response.body)
    assert_includes json_response.keys, "favorited"
    assert_includes json_response.keys, "message"
  end

  test "should handle favorite toggle with session" do
    # 즐겨찾기 추가
    post toggle_favorite_model_url(@model)
    assert_response :success
    
    # 세션에 저장되었는지 확인
    assert_includes session[:favorites], @model.id
    
    # 즐겨찾기 제거
    post toggle_favorite_model_url(@model)
    assert_response :success
    
    # 세션에서 제거되었는지 확인
    refute_includes session[:favorites], @model.id
  end
end
