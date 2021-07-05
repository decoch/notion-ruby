require 'json/ext'
require 'multi_json'

class NotionRuby
  # Custom error class for rescuing from all Notion errors
  class Error < StandardError
    def initialize(response = nil)
      @response = response
      super(build_error_message)
    end

    def response_body
      @response_body ||= (body = @response[:body]) && !body.empty? ? body : nil
    end

    private

    def build_error_message
      return nil if @response.nil?

      message = response_body ? "#{response_body["error"] || response_body["message"] || ''}" : ''
      errors = unless message.empty?
                 response_body["errors"] ? " #{response_body["errors"].to_a.map { |e| e['message'] || e['code'] }.join(', ')} " : ''
               end

      "#{message}#{errors}"
    end
  end

  # Raised when Notion returns a 400 HTTP status code
  class BadRequest < Error; end

  # Raised when Notion returns a 401 HTTP status code
  class Unauthorized < Error; end

  # Raised when Notion returns a 403 HTTP status code
  class Forbidden < Error; end

  # Raised when Notion returns a 404 HTTP status code
  class NotFound < Error; end

  # Raised when Notion returns a 406 HTTP status code
  class NotAcceptable < Error; end

  # Raised when Notion returns a 422 HTTP status code
  class UnprocessableEntity < Error; end

  # Raised when Notion returns a 500 HTTP status code
  class InternalServerError < Error; end

  # Raised when Notion returns a 501 HTTP status code
  class NotImplemented < Error; end

  # Raised when Notion returns a 502 HTTP status code
  class BadGateway < Error; end

  # Raised when Notion returns a 503 HTTP status code
  class ServiceUnavailable < Error; end
end

# @api private
module Faraday
  class Response::RaiseGheeError < Response::Middleware
    ERROR_MAP = {
      400 => NotionRuby::BadRequest,
      401 => NotionRuby::Unauthorized,
      403 => NotionRuby::Forbidden,
      406 => NotionRuby::NotAcceptable,
      422 => NotionRuby::UnprocessableEntity,
      500 => NotionRuby::InternalServerError,
      501 => NotionRuby::NotImplemented,
      502 => NotionRuby::BadGateway,
      503 => NotionRuby::ServiceUnavailable
    }

    def on_complete(response)
      key = response[:status].to_i
      raise ERROR_MAP[key].new(response) if ERROR_MAP.has_key? key
    end
  end
end
