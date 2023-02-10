class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
  
  def record_not_found_response(error)
    # rescue => error 
    # require 'pry';binding.pry
    render json: ErrorSerializer.serialized_response(error, 404), status: 404
    # end
  end
  
  # rescue_from ActiveRecord::InvalidURIError, with: :invalid_url_response
  rescue_from error, with: :standard_error_response
  def standard_error_response(error)
    render json: ErrorSerializer.serialized_response(error, 400), status: 400    
  end


  # rescue DataTypeError => error
  #   render json: ErrorDTSerializer.new(error, 422).serialized_json, status: 422

  # rescue RecordNotFound => error
  #   render json: ErrorRNFSerializer.new(error, 404).serialized_json, status: 404

  # rescue => BadRequestError => error
  #   render json: ErrorBRSerializer.new(error, 400).serialized_json, status: 400
end
