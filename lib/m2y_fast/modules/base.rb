module M2yFast
  require 'savon'
  require 'digest/md5'

  class Base
    def self.get_client
      Savon.client(
        wsdl: M2yFast.configuration.wsdl,
        log: true,
        proxy: M2yFast.configuration.proxy_url,
        log_level: M2yFast.configuration.production? ? :info : :debug,
        pretty_print_xml: true,
        open_timeout: 15,
        read_timeout: 15
      )
    end

    def self.full_response(parsed_response, request, original_response)
      parsed_response = { body: parsed_response } if parsed_response.is_a?(Array)
      parsed_response = {} unless parsed_response.is_a?(Hash)
      parsed_response[:original_response] = original_response.to_json
      parsed_response[:original_request] = request
      parsed_response
    end
  end
end