require "test_helper"

class CompareControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get compare_index_url
    assert_response :success
  end

  test "should get add" do
    get compare_add_url
    assert_response :success
  end

  test "should get remove" do
    get compare_remove_url
    assert_response :success
  end

  test "should get clear" do
    get compare_clear_url
    assert_response :success
  end
end
