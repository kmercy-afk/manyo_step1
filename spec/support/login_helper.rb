module LoginHelper
  def login_as(user)
    visit test_login_path(user)
  end
end

RSpec.configure do |config|
  config.include LoginHelper, type: :system
end