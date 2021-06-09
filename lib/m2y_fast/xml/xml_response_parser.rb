# frozen_string_literal: true

module M2yFast
  class XmlResponseParser

    def self.get_user_registration_response(json)
      begin
        xml_str = json[:dados_gral_portador_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        { error: codigo_retorno != 0, code: codigo_retorno }
      rescue
        { error: true }
      end
    end

    def self.update_user_registration_response(json)
      begin
        xml_str = json[:alteracao_portador2_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        { error: (codigo_retorno != 0 && codigo_retorno != 1000), code: codigo_retorno }
      rescue
        { error: true }
      end
    end

    def self.request_card_response(json, body)
      begin
        xml_str = json[:cadastro_cartao_geral_response][:return]
        card = xml_str.split("<cartao>").last.split("</cartao>").first
        account_id = xml_str.split("<conta>").last.split("</conta>").first
        card_date = xml_str.split("<data_vencimento>").last.split("</data_vencimento>").first
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        error = (card.blank? || (codigo_retorno != 0 && codigo_retorno != 1000))
        return { card_id: nil, account_id: nil, error: true, code: codigo_retorno } if error

        {
          card_id: body[:proxy],
          card: card,
          account_id: account_id,
          card_date: card_date,
          registration: body[:registration],
          error: card.blank?
        }
      rescue
        { card_id: nil, account_id: nil, error: true }
      end
    end

    def self.register_password_response(json)
      begin
        xml_str = json[:cadastra_senha_cert_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        { error: codigo_retorno != 0, code: codigo_retorno }
      rescue
        { error: true }
      end
    end

    def self.block_card_response(json)
      begin
        xml_str = json[:bloqueio_cartao_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        {error: codigo_retorno != 0, code: codigo_retorno}
      rescue
        {error: true}
      end
    end

    def self.activate_card_response(json)
      begin
        xml_str = json[:ativacao_cartao_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        { error: codigo_retorno != 0, code: codigo_retorno }
      rescue
        { error: true }
      end
    end

    def self.check_card_response(json)
      begin
        xml_str = json[:retorna_status_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        status = xml_str.split("<status>").last.split("</status>").first
        desc_status = xml_str.split("<desc_status>").last.split("</desc_status>").first

        {error: codigo_retorno != 0, code: codigo_retorno, desc_status: desc_status, status: status}
      rescue
        {error: true}
      end
    end

    def self.update_password_response(json)
      begin
        xml_str = json[:alterar_senha_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        {error: codigo_retorno != 0, code: codigo_retorno}
      rescue
        {error: true}
      end
    end

    def self.validate_password_response(json)
      begin
        xml_str = json[:verifica_senha_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        cod_ret = xml_str.split("<cod_ret>").last.split("</cod_ret>").first.to_i
        error = (codigo_retorno != 0 || cod_ret != 0)
        { error: error, code: codigo_retorno }
      rescue
        { error: true }
      end
    end

  end
end
