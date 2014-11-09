class ApplicationController < ActionController::Base
  protect_from_forgery
  include KaminariHelper
  include PublicActivity::StoreController
  # ...
   hide_action :current_user
end
