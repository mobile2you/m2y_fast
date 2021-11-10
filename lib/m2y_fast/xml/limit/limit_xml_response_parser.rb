module M2yFast
  class LimitXmlResponseParser
    # gera_autorizacao
    def self.generate_authorization_response(json)
      begin
        xml_str = json[:gera_autorizacao_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i
        card_number = parsed_hash.dig(:gera_autorizacao, :cartao) || []
        card_number = card_number.first if card_number.is_a?(Array)

        {
          error: return_code != 0,
          code: return_code,
          card_number: card_number
        }
      rescue
        { error: true }
      end
    end
  end
end