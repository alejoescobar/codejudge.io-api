class Api::V1::ApiController < ApplicationController
  include Authenticable
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || pages_profile_path
  end
end
