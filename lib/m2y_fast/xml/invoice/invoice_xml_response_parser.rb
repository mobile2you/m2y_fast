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
          invoices: parsed_hash[:consulta_faturas][:row]
        }
      rescue
        { error: true }
      end
    end
  end
end