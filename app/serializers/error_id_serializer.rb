class ErrorIDSerializer
  def initialize(errors)
    @errors = errors
  end
  
  def serialized_json
    {
      "errors": [ {
            "error_message": @errors.error_message,
            "status": @errors.status,          
      } ]
    }
  end
end