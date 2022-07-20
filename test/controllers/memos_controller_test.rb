require "test_helper"

class MemosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @memo = memos(:one)
  end

  test "should get index" do
    get memos_url, as: :json
    assert_response :success
  end

  test "should create memo" do
    assert_difference("Memo.count") do
      post memos_url, params: { memo: { color_code: @memo.color_code, color_file_id: @memo.color_file_id, comment: @memo.comment, tag_id: @memo.tag_id, url: @memo.url, user_id: @memo.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show memo" do
    get memo_url(@memo), as: :json
    assert_response :success
  end

  test "should update memo" do
    patch memo_url(@memo), params: { memo: { color_code: @memo.color_code, color_file_id: @memo.color_file_id, comment: @memo.comment, tag_id: @memo.tag_id, url: @memo.url, user_id: @memo.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy memo" do
    assert_difference("Memo.count", -1) do
      delete memo_url(@memo), as: :json
    end

    assert_response :no_content
  end
end
