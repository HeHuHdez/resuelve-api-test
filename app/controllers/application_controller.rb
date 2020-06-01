# frozen_string_literal: true

# Parent class of controllers
class ApplicationController < ActionController::API
  # Method to handle missing params exceptions
  rescue_from ActionController::ParameterMissing do |_e|
    render json: { error: 'The list of params is missing' }, status: :bad_request
  end
end
