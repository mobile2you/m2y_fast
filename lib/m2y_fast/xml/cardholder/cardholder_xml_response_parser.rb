# frozen_string_literal: true
module M2yFast
  class CardholderXmlResponseParser

    # consulta_portador
    def self.get_cardholder_response(json)
      begin
        xml_str = json[:consulta_portador_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        { error: codigo_retorno != 0, code: codigo_retorno }
      rescue
        { error: true }
      end
    end

    # dados_gral_portador
    def self.get_user_registration_response(json)
      begin
        xml_str = json[:dados_gral_portador_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        { error: codigo_retorno != 0, code: codigo_retorno }
      rescue
        { error: true }
      end
    end

    # alteracao_portador2
    def self.update_user_registration_response(json)
      begin
        xml_str = json[:alteracao_portador2_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        { error: (codigo_retorno != 0 && codigo_retorno != 1000), code: codigo_retorno }
      rescue
        { error: true }
      end
    end

    # cartoes_cpf
    def self.account_for_document_response(json)
      begin
        xml_str = json[:cartoes_cpf_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        account = parsed_hash.dig(:cartoes_cpf, :conta)
        account = account.first if account.is_a?(Array)

        {
          error: return_code != 0,
          code: return_code,
          account: account
        }
      rescue StandardError => e
        { error: true, message: e.message }
      end
    end

    # consulta_informacao_portador
    def self.cards_for_document_response(json)
      begin
        xml_str = json[:consulta_informacao_portador_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        cards = parsed_hash.dig(:consulta_informacao_portador, :row) || []
        cards = [cards] if !cards.is_a?(Array)

        {
          error: (return_code != 0 && return_code != 14),
          code: return_code,
          cards: cards
        }
      rescue StandardError => e
        { error: true, message: e.message }
      end
    end
  end
end
