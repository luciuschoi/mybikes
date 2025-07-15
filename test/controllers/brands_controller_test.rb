require "test_helper"

class BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = brands(:honda)
  end

  test "should get index" do
    get brands_url
    assert_response :success
    assert_select "h1", "브랜드"
  end

  test "should get show" do
    get brand_url(@brand)
    assert_response :success
    assert_select "h1", @brand.name
  end

  test "should filter brands by search" do
    get brands_url, params: { search: "Honda" }
    assert_response :success
    assert_select ".brand-card", minimum: 1
  end

  test "should filter brands by country" do
    get brands_url, params: { country: "Japan" }
    assert_response :success
    assert_select ".brand-card", minimum: 1
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
