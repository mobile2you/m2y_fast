module M2yFast
  class Card < Base

    # cadastro_cartao_geral
    def self.request_card(body)
      body[:registration] = (Time.now.to_i.to_s + Random.rand(99).to_s).to_i
      xml = XmlBuilder.request_card_xml(body)
      response = M2yFast.configuration.savon_client.call(:cadastro_cartao_geral, xml: xml)
      full_response(XmlResponseParser.request_card_response(response.body, body), xml, response.body, :cadastro_cartao_geral)
    end

    # cadastra_senha_cert
    def self.register_password(card_id, encrypted_password)
      xml = XmlBuilder.register_password_xml(card_id, encrypted_password, trace)
      response = M2yFast.configuration.savon_client.call(:cadastra_senha_cert, xml: xml)
      full_response(XmlResponseParser.register_password_response(response.body), xml, response.body, :cadastra_senha_cert)
    end

    # bloqueio_cartao
    def self.block_card(card_id, cod_input)
      xml = XmlBuilder.block_card_xml(card_id, trace, cod_input)
      response = M2yFast.configuration.savon_client.call(:bloqueio_cartao, xml: xml)
      full_response(XmlResponseParser.block_card_response(response.body), xml, response.body, :bloqueio_cartao)
    end

    # verifica_senha
    def self.validate_password(card_id, password)
      xml = XmlBuilder.validate_password_xml(card_id, password, trace)
      response = M2yFast.configuration.savon_client.call(:verifica_senha, xml: xml)
      full_response(XmlResponseParser.validate_password_response(response.body), xml, response.body, :verifica_senha)
    end

    # alterar_senha
    def self.update_password(body)
      body[:trace] = trace
      xml = XmlBuilder.update_password_xml(body)
      response = M2yFast.configuration.savon_client.call(:alterar_senha, xml: xml)
      full_response(XmlResponseParser.update_password_response(response.body), xml, response.body, :alterar_senha)
    end

    # ativacao_cartao
    def self.activate_card(card_id)
      xml = XmlBuilder.activate_card_xml(card_id, trace)
      response = M2yFast.configuration.savon_client.call(:ativacao_cartao, xml: xml)
      full_response(XmlResponseParser.activate_card_response(response.body), xml, response.body, :ativacao_cartao)
    end

    # retorna_status
    def self.check_card(card_id)
      xml = XmlBuilder.check_card_xml(card_id, trace)
      response = M2yFast.configuration.savon_client.call(:retorna_status, xml: xml)
      full_response(XmlResponseParser.check_card_response(response.body), xml, response.body, :retorna_status)
    end

    # verifica_cvv_cert
    def self.check_cvv(body)
      xml = XmlBuilder.check_cvv_xml(body, trace)
      response = M2yFast.configuration.savon_client.call(:verifica_cvv_cert, xml: xml)
      full_response(XmlResponseParser.check_cvv_response(response.body), xml, response.body, :verifica_cvv_cert)
    end

    # retorna_pin_cert
    def self.recall_password(card_id)
      xml = XmlBuilder.recall_password_xml(card_id, trace)
      response = M2yFast.configuration.savon_client.call(:retorna_pin_cert, xml: xml)
      full_response(XmlResponseParser.recall_password_response(response.body), xml, response.body, :retorna_pin_cert)
    end

    # melhor_dia_para_compras
    def self.best_day_for_shopping(card_id)
      xml = XmlBuilder.best_day_for_shopping_xml(card_id)
      response = M2yFast.configuration.savon_client.call(:melhor_dia_para_compras, xml: xml)
      full_response(XmlResponseParser.best_day_for_shopping_response(response.body), xml, response.body, :melhor_dia_para_compras)
    end

    # This method makes two calls to the FAST API in order to reduce any overhead in processing
    # retorna_status + consulta_disponivel
    def self.card_data(card_id)
      status_response = soap_post(XmlBuilder.check_card_xml(card_id, trace))
      partial_response = status_response.body.split("<return>").last.split("</return>").first
      partial_return_code = partial_response.split("&lt;codigo_retorno&gt;").last.split("&lt;/codigo_retorno&gt;").first
      partial_status = partial_response.split("&lt;desc_status&gt;").last.split("&lt;/desc_status&gt;").first.to_s.upcase
      # First request returns error
      if partial_return_code != '00'
        {
          error: true,
          code: partial_return_code.to_i
        }
      # If card is not active, there is no need to check card limit
      elsif partial_status.in?(['CARTAO APROVADO',
                                'ENVIADO PARA EMBOSSADORA',
                                'ENVIADO ARQ. PARA DELIVERY',
                                'ENVIADO ARQ PARA DELIVERY',
                                'EMBOSSADO',
                                'ENVIADO AO PORTADOR'])
        XmlResponseParser.card_data_response(status_response, nil)
      else
        limit_response = soap_post(LimitXmlBuilder.card_limit_xml(card_id))
        XmlResponseParser.card_data_response(status_response, limit_response)
      end
    end
  end
end
