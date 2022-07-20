require "test_helper"

class MemoFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @memo_file = memo_files(:one)
  end

  test "should get index" do
    get memo_files_url, as: :json
    assert_response :success
  end

  test "should create memo_file" do
    assert_difference("MemoFile.count") do
      post memo_files_url, params: { memo_file: { color_file_id: @memo_file.color_file_id, memo_id: @memo_file.memo_id } }, as: :json
    end

    assert_response :created
  end

  test "should show memo_file" do
    get memo_file_url(@memo_file), as: :json
    assert_response :success
  end

  test "should update memo_file" do
    patch memo_file_url(@memo_file), params: { memo_file: { color_file_id: @memo_file.color_file_id, memo_id: @memo_file.memo_id } }, as: :json
    assert_response :success
  end

  test "should destroy memo_file" do
    assert_difference("MemoFile.count", -1) do
      delete memo_file_url(@memo_file), as: :json
    end

    assert_response :no_content
  end
end
