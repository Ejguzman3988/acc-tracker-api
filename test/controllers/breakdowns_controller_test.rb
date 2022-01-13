require "test_helper"

class BreakdownsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @breakdown = breakdowns(:one)
  end

  test "should get index" do
    get breakdowns_url, as: :json
    assert_response :success
  end

  test "should create breakdown" do
    assert_difference('Breakdown.count') do
      post breakdowns_url, params: { breakdown: { week_range: @breakdown.week_range } }, as: :json
    end

    assert_response 201
  end

  test "should show breakdown" do
    get breakdown_url(@breakdown), as: :json
    assert_response :success
  end

  test "should update breakdown" do
    patch breakdown_url(@breakdown), params: { breakdown: { week_range: @breakdown.week_range } }, as: :json
    assert_response 200
  end

  test "should destroy breakdown" do
    assert_difference('Breakdown.count', -1) do
      delete breakdown_url(@breakdown), as: :json
    end

    assert_response 204
  end
end
