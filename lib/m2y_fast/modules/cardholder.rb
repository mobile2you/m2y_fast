module M2yFast

  require "savon"
  require 'digest/md5'

  class Cardholder
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

    def self.get_cardholder(body)
      client = get_client
      xml = XmlBuilder.get_cardholder_xml(body)
      response = client.call(:consulta_portador, xml: xml)
      XmlResponseParser.get_cardholder_response(response.body)
    end

    def self.get_user_registration(card_id)
      client = get_client
      xml = XmlBuilder.get_user_registration_xml(card_id)
      response = client.call(:dados_gral_portador, xml: xml)
      XmlResponseParser.get_user_registration_response(response.body)
    end

    def self.update_user_registration(body)
      client = get_client
      xml = XmlBuilder.update_user_registration_xml(body)
      response = client.call(:alteracao_portador2, xml: xml)
      XmlResponseParser.update_user_registration_response(response.body)
    end
  end
end
