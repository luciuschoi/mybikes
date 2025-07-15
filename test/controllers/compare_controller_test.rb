require "test_helper"

class CompareControllerTest < ActionDispatch::IntegrationTest
  setup do
    @model1 = models(:cbr1000rr)
    @model2 = models(:ninja_zx10r)
  end

  test "should get index" do
    get compare_url
    assert_response :success
    assert_select "h1", "모델 비교"
  end

  test "should add model to compare" do
    post add_to_compare_url(@model1)
    assert_redirected_to models_path
    
    # 세션에 추가되었는지 확인
    assert_includes session[:compare_list], @model1.id
  end

  test "should not add more than 2 models to compare" do
    # 첫 번째 모델 추가
    post add_to_compare_url(@model1)
    assert_redirected_to models_path
    
    # 두 번째 모델 추가
    post add_to_compare_url(@model2)
    assert_redirected_to models_path
    
    # 세 번째 모델 추가 시도 (실패해야 함)
    third_model = models(:r1)
    post add_to_compare_url(third_model)
    assert_redirected_to models_path
    
    # 세션에 2개만 있어야 함
    assert_equal 2, session[:compare_list].length
  end

  test "should remove model from compare" do
    # 모델 추가
    post add_to_compare_url(@model1)
    
    # 모델 제거
    delete remove_from_compare_url(@model1)
    assert_redirected_to compare_path
    
    # 세션에서 제거되었는지 확인
    refute_includes session[:compare_list], @model1.id
  end

  test "should clear compare list" do
    # 모델들 추가
    post add_to_compare_url(@model1)
    post add_to_compare_url(@model2)
    
    # 비교 목록 초기화
    delete clear_compare_url
    assert_redirected_to compare_path
    
    # 세션이 비어있는지 확인
    assert_empty session[:compare_list]
  end

  test "should show compare page with models" do
    # 모델들 추가
    post add_to_compare_url(@model1)
    post add_to_compare_url(@model2)
    
    # 비교 페이지 확인
    get compare_url
    assert_response :success
    # 실제 구현에 맞게 수정 (비교 테이블이 있는지 확인)
    assert_select "table", minimum: 1
  end
end
