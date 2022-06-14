module M2yFast
  class VirtualCard < Base

    #cadastro_cartao_virtual
    def self.request_virtual_card(body)
      xml = VirtualCardXmlBuilder.request_virtual_card_xml(body)
      response = M2yFast.configuration.savon_client.call(:cadastro_cartao_virtual, xml: xml)
      full_response(VirtualCardXmlResponseParser.request_virtual_card_response(response.body), xml, response.body, :cadastro_cartao_virtual)
    end

    #cartao_virtual_cert
    def show_virtual_card(card_number)
      xml = VirtualCardXmlBuilder.show_virtual_card_xml(card_number)
      response = M2yFast.configuration.savon_client.call(:cartao_virtual_cert, xml: xml)
      full_response(VirtualCardXmlResponseParser.show_virtual_card_response(response.body), xml, response.body, :cartao_virtual_cert)
    end
  end
end