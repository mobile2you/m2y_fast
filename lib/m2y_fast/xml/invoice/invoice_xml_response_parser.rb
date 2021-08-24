# frozen_string_literal: true
module M2yFast
  class InvoiceXmlResponseParser
    # consulta_faturas
    def self.get_invoices_response(json)
      begin
        xml_str = json[:consulta_faturas_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        {
          error: return_code != 0,
          code: return_code,
          invoices: parsed_hash.dig(:consulta_faturas, :row) || []
        }
      rescue
        { error: true }
      end
    end

    # consulta_fatura_aberta
    def self.get_current_invoice_response(json)
      begin
        xml_str = json[:consulta_fatura_aberta_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i
        invoice = parsed_hash.dig(:consulta_fatura_aberta, :row)
        invoice = invoice.last if invoice.is_a?(Array)

        {
          error: return_code != 0,
          code: return_code,
          invoice: invoice
        }
      rescue
        { error: true }
      end
    end

    # consulta_detalhe_fatura
    def self.get_invoice_items_response(json)
      begin
        xml_str = json[:consulta_detalhe_fatura_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        {
          error: return_code != 0,
          code: return_code,
          items: parsed_hash.dig(:consulta_detalhe_fatura, :row) || []
        }
      rescue
        { error: true }
      end
    end
  end
end