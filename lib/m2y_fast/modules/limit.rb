module M2yFast
  class Limit < Base
    # cadastra um valor de crédito para o user
    def self.generate_authorization(card_id, value)
      client = get_client
      xml = LimitXmlBuilder.generate_authorization_xml(card_id, value, trace)
      response = client.call(:gera_autorizacao, xml: xml)
      full_response(LimitXmlResponseParser.generate_authorization_response(response.body), xml, response.body)
    end
  end
end