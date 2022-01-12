require "test_helper"

class ModsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mod = mods(:one)
  end

  test "should get index" do
    get mods_url, as: :json
    assert_response :success
  end

  test "should create mod" do
    assert_difference('Mod.count') do
      post mods_url, params: { mod: { amount: @mod.amount, optional: @mod.optional, phase_id: @mod.phase_id, title: @mod.title } }, as: :json
    end

    assert_response 201
  end

  test "should show mod" do
    get mod_url(@mod), as: :json
    assert_response :success
  end

  test "should update mod" do
    patch mod_url(@mod), params: { mod: { amount: @mod.amount, optional: @mod.optional, phase_id: @mod.phase_id, title: @mod.title } }, as: :json
    assert_response 200
  end

  test "should destroy mod" do
    assert_difference('Mod.count', -1) do
      delete mod_url(@mod), as: :json
    end

    assert_response 204
  end
end
