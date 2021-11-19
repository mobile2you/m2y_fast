module M2yFast
  class Statement < Base
    # consulta_faturas
    # Obs: paginacao foi desabilitada pela Fast
    def self.get_statement(fast_account)
      xml = StatementXmlBuilder.get_statement_xml(fast_account)
      response = M2yFast.configuration.savon_client.call(:consulta_faturas, xml: xml)
      full_response(StatementXmlResponseParser.get_statement_response(response.body), xml, response.body)
    end

    # consulta_fatura_aberta
    # Obs: paginacao foi desabilitada pela Fast
    def self.get_current_invoice(fast_account)
      xml = StatementXmlBuilder.get_current_invoice_xml(fast_account)
      response = M2yFast.configuration.savon_client.call(:consulta_fatura_aberta, xml: xml)
      full_response(StatementXmlResponseParser.get_current_invoice_response(response.body), xml, response.body)
    end

    # consulta_detalhe_fatura
    # Obs: paginacao foi desabilitada pela Fast
    def self.get_statement_detail(fast_account, period)
      xml = StatementXmlBuilder.get_statement_detail_xml(fast_account, period)
      response = M2yFast.configuration.savon_client.call(:consulta_detalhe_fatura, xml: xml)
      full_response(StatementXmlResponseParser.get_statement_detail_xml_response(response.body), xml, response.body)
    end

    # gera_boleto
    def self.get_statement_billet(fast_account, period)
      xml = StatementXmlBuilder.get_statement_billet_xml(fast_account, period)
      response = M2yFast.configuration.savon_client.call(:gera_boleto, xml: xml)
      full_response(StatementXmlResponseParser.get_statement_billet_xml_response(response.body), xml, response.body)
    end
  end
end
