# frozen_string_literal: true

# Parent class of controllers
class ApplicationController < ActionController::API
  # Method to handle missing params exceptions
  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: e.message }, status: :bad_request
  end
end
