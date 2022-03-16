module M2yFast
  class VirtualCardXmlResponseParser

    #cadastro_cartao_virtual
    def self.request_virtual_card_response(json)
      begin
        xml_str = json[:cadastro_cartao_virtualResponse][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        virtual_card = parsed_hash.dig(:cadastro_cartao_virtual, :row) || []
        virtual_card = [virtual_card] if !virtual_card.is_a?(Array)

        {
          error: return_code != 0,
          code: return_code,
          virtual_card_number: virtual_card[:cartao],
          expiration_date: virtual_card[:data_vencimento]

        }
      rescue
        { error: true }
      end
    end

    #cartao_virtual_cert
    def show_virtual_card_response(json)
      begin
        xml_str = json[:cartao_virtual_certResponse][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        virtual_card = parsed_hash.dig(:cartao_virtual_cert, :row) || []
        virtual_card = [virtual_card] if !virtual_card.is_a?(Array)

        {
          error: return_code != 0,
          code: return_code,
          virtual_card_number: virtual_card[:cartao],
          expiration_date: virtual_card[:data_vencimento],
          embossing_name: virtual_card[:nome_embossing],
          cvv: virtual_card[:CVC2]

        }
      rescue
        { error: true }
      end
    end

  end
end