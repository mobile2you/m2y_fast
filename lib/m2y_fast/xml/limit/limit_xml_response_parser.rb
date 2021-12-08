module M2yFast
  class LimitXmlResponseParser

    # consulta_disponivel
    def self.card_limit_response(json)
      begin
        xml_str = json[:consulta_disponivel_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        limit = xml_str.split("<limite_credito>").last.split("</limite_credito>").first.gsub(',', '.').to_f
        available_for_withdrawal = xml_str.split("<disponivel_saques>").last.split("</disponivel_saques>").first.gsub(',', '.').to_f
        available_for_shopping = xml_str.split("<disponivel_compras>").last.split("</disponivel_compras>").first.gsub(',', '.').to_f
        balance = xml_str.split("<saldo_atual>").last.split("</saldo_atual>").first.gsub(',', '.').to_f
        blocked_value = xml_str.split("<bloqueio_judicial>").last.split("</bloqueio_judicial>").first.gsub(',', '.').to_f
        cardholder_name = xml_str.split("<nome>").last.split("</nome>").first

        {
          error: codigo_retorno != 0,
          code: codigo_retorno,
          limit: limit,
          available_for_withdrawal: available_for_withdrawal,
          available_for_shopping: available_for_shopping,
          balance: balance,
          blocked_value: blocked_value,
          name: cardholder_name
        }
      rescue
        { error: true }
      end
    end

    # alterar_limite
    def self.update_limit_response(json)
      begin
        xml_str = json[:alterar_limite_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        cod_ret = xml_str.split("<cod_ret>").last.split("</cod_ret>").first.to_i

        {
          error: (codigo_retorno != 0 || cod_ret != 0),
          code: codigo_retorno
        }
      rescue
        { error: true }
      end
    end

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