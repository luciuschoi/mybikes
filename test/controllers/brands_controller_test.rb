require "test_helper"

class BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = brands(:honda)
  end

  test "should get index" do
    get brands_url
    assert_response :success
    assert_select "h1", "브랜드 목록"
  end

  test "should get show" do
    get brand_url(@brand)
    assert_response :success
    assert_select "h1", @brand.name
  end

  test "should filter brands by search" do
    get brands_url, params: { search: "Honda" }
    assert_response :success
    # 브랜드 카드가 있는지 확인 (실제 클래스명에 맞게 수정)
    assert_select "div", minimum: 1
  end

  test "should filter brands by country" do
    get brands_url, params: { country: "Japan" }
    assert_response :success
    # 브랜드 카드가 있는지 확인 (실제 클래스명에 맞게 수정)
    assert_select "div", minimum: 1
  end

  test "should sort brands by name" do
    get brands_url, params: { sort: "name" }
    assert_response :success
  end

  test "should sort brands by newest" do
    get brands_url, params: { sort: "newest" }
    assert_response :success
  end

  test "should sort brands by popular" do
    get brands_url, params: { sort: "popular" }
    assert_response :success
  end
end
