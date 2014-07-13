require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:one)
    @notes = notes(:one, :two)
    @short = notes(:short)
  end

  def json
    ActiveSupport::JSON.decode @response.body
  end

  test "should get index" do
    get :index

    assert_equal(@notes.count, 2)
    assert_response :ok
    assert_not_nil assigns(:notes)
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, note: { title: @note.title }
    end

    assert_equal(@note.title, json['note']['title'])
    assert_response :created
  end

  test "should not create note" do
    post :create, note: { title: @short.title }
    
    assert_response :unprocessable_entity
  end

  test "should show note" do
    get :show, id: @note
    
    assert_equal(@note.title, json['note']['title'])
    assert_response :ok
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete :destroy, id: @note
    end

    assert_response :no_content
  end
end
