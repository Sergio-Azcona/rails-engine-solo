class ErrorSerializer
  def self.serialized_response(errors, status_code)
    # require 'pry';binding.pry
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