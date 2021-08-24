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

    def self.get_current_invoice
    end

    def self.get_invoice_itens
    end
  end
end
