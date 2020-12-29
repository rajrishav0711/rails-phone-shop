require 'test_helper'

class Admin::PhonesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_phones_index_url
    assert_response :success
  end

end
