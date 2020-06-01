class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: 'Could not find a valid list of params' }
  end
end
