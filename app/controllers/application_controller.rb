class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(msg = 'Not found')
    render json: { code: 404, message: msg }, status: 404
  end
end
