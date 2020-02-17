class FreshstartApplicationsController < Doorkeeper::ApplicationsController
  http_basic_authenticate_with :name => ADMIN_LOGIN, :password => ADMIN_PASSWORD
end