module M2yFast
  require 'savon'
  require 'digest/md5'
  require 'active_support/core_ext'

  class Base
    def self.get_client
      Savon.client(
        wsdl: M2yFast.configuration.wsdl,
        log: true,
        proxy: M2yFast.configuration.proxy,
        log_level: M2yFast.configuration.production? ? :info : :debug,
        pretty_print_xml: true,
        open_timeout: 15,
        read_timeout: 15
      )
    end

    def self.fixie
      URI.parse M2yFast.configuration.proxy
    end

    def self.base_headers
      headers = {}
      headers['Content-Type'] = 'application/json'
      headers
    end

    def self.soap_post(body)
      url = M2yFast.configuration.wsdl.gsub('?wsdl', '')
      xml_headers = {}
      xml_headers['Content-Type'] = 'text/xml'
      xml_headers['charset'] = 'utf-8'
      post(url, body, xml_headers)
    end

    def self.post(url, body, headers = nil)
      if headers.nil?
        headers = base_headers
      end
      # puts "Sending POST request to URL: #{url}"
      # puts body
      HTTParty.post(url, headers: headers, body: body,
                    http_proxyaddr: fixie.host,
                    http_proxyport: fixie.port,
                    http_proxyuser: fixie.user,
                    http_proxypass: fixie.password)
    end

    def self.trace
      rand(100000..999999)
    end

    def self.full_response(parsed_response, request, original_response, endpoint = nil)
      parsed_response = { body: parsed_response } if parsed_response.is_a?(Array)
      parsed_response = {} unless parsed_response.is_a?(Hash)
      parsed_response[:original_response] = original_response.to_json
      parsed_response[:original_request] = request
      parsed_response[:url] = endpoint.to_s
      parsed_response
    end
  end
end
