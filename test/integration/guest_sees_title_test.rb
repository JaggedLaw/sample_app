require 'test_helper'

class GuestSeesTitleTest < ActionDispatch::IntegrationTest

  test 'guest sees correct titles' do
    visit static_pages_about_path
    assert page.has_content?("About")
    visit root_path
    assert page.has_content?("Sample App")
    visit static_pages_help_path
    assert page.has_content?("Help")
  end
end
