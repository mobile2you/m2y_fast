module M2yFast
  class Cardholder < Base
    # consulta_portador
    def self.get_cardholder(body)
      client = get_client
      xml = CardholderXmlBuilder.get_cardholder_xml(body)
      response = client.call(:consulta_portador, xml: xml)
      full_response(CardholderXmlResponseParser.get_cardholder_response(response.body), xml, response.body)
    end

    # dados_gral_portador
    def self.get_user_registration(card_id)
      client = get_client
      xml = CardholderXmlBuilder.get_user_registration_xml(card_id)
      response = client.call(:dados_gral_portador, xml: xml)
      full_response(CardholderXmlResponseParser.get_user_registration_response(response.body), xml, response.body)
    end

    # alteracao_portador2
    def self.update_user_registration(body)
      client = get_client
      xml = CardholderXmlBuilder.update_user_registration_xml(body)
      response = client.call(:alteracao_portador2, xml: xml)
      full_response(CardholderXmlResponseParser.update_user_registration_response(response.body), xml, response.body)
    end
  end
end
