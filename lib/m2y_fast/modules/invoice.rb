module M2yFast
  class Invoice < Base
    # consulta_faturas
    # Obs: paginacao foi desabilitada pela Fast
    def self.get_invoices(fast_account)
      client = get_client
      xml = InvoiceXmlBuilder.get_invoices_xml(fast_account)
      response = client.call(:consulta_faturas, xml: xml)
      full_response(InvoiceXmlResponseParser.get_invoices_response(response.body), xml, response.body)
    end

    # consulta_fatura_aberta
    # Obs: paginacao foi desabilitada pela Fast
    def self.get_current_invoice(fast_account)
      client = get_client
      xml = InvoiceXmlBuilder.get_current_invoice_xml(fast_account)
      response = client.call(:consulta_fatura_aberta, xml: xml)
      full_response(InvoiceXmlResponseParser.get_current_invoice_response(response.body), xml, response.body)
    end

    # consulta_detalhe_fatura
    # Obs: paginacao foi desabilitada pela Fast
    def self.get_invoice_items(fast_account, period)
      client = get_client
      xml = InvoiceXmlBuilder.get_invoice_items_xml(fast_account, period)
      response = client.call(:consulta_detalhe_fatura, xml: xml)
      full_response(InvoiceXmlResponseParser.get_invoice_items_response(response.body), xml, response.body)
    end
  end
end
