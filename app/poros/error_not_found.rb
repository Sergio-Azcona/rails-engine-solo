class ErrorNotFound
  attr_reader :error_message, :status, :code
  def initialize(error_message, status)
      @error_message = "No object found with id: #{error_message}"
      @status = status
  end
end