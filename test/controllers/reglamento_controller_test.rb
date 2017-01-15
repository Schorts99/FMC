require 'test_helper'

class ReglamentoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reglamento_index_url
    assert_response :success
  end

end
