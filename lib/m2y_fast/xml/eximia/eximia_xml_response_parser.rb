# frozen_string_literal: true
module M2yFast
  class EximiaXmlResponseParser
    def self.get_pdf_id_response(json)
      xml_str = json[:find_conta_dta_venc_response][:return]

      puts xml_str
      xml_str
      # parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
      # return_code = parsed_hash[:codigo_retorno].to_i
      # card_number = parsed_hash.dig(:gera_autorizacao, :cartao) || []
      # card_number = card_number.first if card_number.is_a?(Array)

      # {
      #   error: return_code != 0,
      #   code: return_code,
      #   card_number: card_number
      # }
    rescue
      { error: true }
    end
  end
end
