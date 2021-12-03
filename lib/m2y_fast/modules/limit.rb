module M2yFast
  class Limit < Base
    # gera_autorizacao
    # cadastra um valor de crédito para o user
    def self.generate_authorization(card_id, value)
      xml = LimitXmlBuilder.generate_authorization_xml(card_id, value, trace)
      response = M2yFast.configuration.savon_client.call(:gera_autorizacao, xml: xml)
      full_response(LimitXmlResponseParser.generate_authorization_response(response.body), xml, response.body, :gera_autorizacao)
    end
  end
end
