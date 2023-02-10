class ErrorSerializer
  # def initialize(errors, status_code)
  #   @errors = errors
  #   @status_code = status_code
  # end
  
  def self.serialized_response(errors, status_code)
    {
        "errors":
        [ 
          {
          "error_message": errors.message,
          "status": status_code.to_s, 
          } 
        ]
    }
  end
end