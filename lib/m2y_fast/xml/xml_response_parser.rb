# frozen_string_literal: true

module M2yFast
  class XmlResponseParser

    ### CARD ###

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
        cod_ret = xml_str.split("<cod_ret>").last.split("</cod_ret>").first.to_i
        error = (codigo_retorno != 0 || cod_ret != 0)
        {error: error, code: codigo_retorno}
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
        card_number = xml_str.split("<cartao>").last.split("</cartao>").first

        {
          error: codigo_retorno != 0,
          code: codigo_retorno,
          desc_status: desc_status,
          status: status,
          card_number: card_number
        }
      rescue
        {error: true}
      end
    end

    def self.update_password_response(json)
      begin
        xml_str = json[:alterar_senha_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        cod_ret = xml_str.split("<cod_ret>").last.split("</cod_ret>").first.to_i
        error = (codigo_retorno != 0 || cod_ret != 0)
        {error: error, code: codigo_retorno}
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

    def self.check_cvv_response(json)
      begin
        xml_str = json[:verifica_cvv_cert_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        cod_ret = xml_str.split("<cod_ret>").last.split("</cod_ret>").first.to_i
        error = (codigo_retorno != 0 || cod_ret != 0)
        {
          error: error,
          code: codigo_retorno,
          data_error_code: cod_ret
        }
      rescue
        { error: true }
      end
    end

    def self.recall_password_response(json)
      begin
        xml_str = json[:retorna_pin_cert_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        cod_ret = xml_str.split("<cod_ret>").last.split("</cod_ret>").first.to_i
        card_number = xml_str.split("<cartao>").last.split("</cartao>").first
        card_password = xml_str.split("<senha>").last.split("</senha>").first
        {
          error: (codigo_retorno != 0 || cod_ret != 0),
          code: codigo_retorno,
          data_error_code: cod_ret,
          card_number: card_number,
          card_password: card_password
        }
      rescue
        { error: true }
      end
    end

    # melhor_dia_para_compras
    def self.best_day_for_shopping_response(json)
      begin
        xml_str = json[:melhor_dia_para_compras_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i

        {
          error: (codigo_retorno != 0),
          code: codigo_retorno,
          best_day: xml_str.split("<melhor_dia>").last.split("</melhor_dia>").first
        }
      rescue
        { error: true }
      end
    end

    # retorna_status + consulta_disponivel
    def self.card_data_response(status_response, limit_response)
      status_response = status_response.body.split('<return>').last.split('</return>').first

      response = {
        desc_status: status_response.split('&lt;desc_status&gt;').last.split('&lt;/desc_status&gt;').first,
        status: status_response.split('&lt;status&gt;').last.split('&lt;/status&gt;').first,
        card_number: status_response.split('&lt;cartao&gt;').last.split('&lt;/cartao&gt;').first,
      }

      if limit_response.present?
        # Merge with limit data if present
        limit_response = limit_response.body.split('<return>').last.split('</return>').first
        codigo_retorno = limit_response.split('&lt;codigo_retorno&gt;').last.split('&lt;/codigo_retorno&gt;').first.to_i
        response.merge!({
          error: codigo_retorno != 0,
          code: codigo_retorno,
          limit: limit_response.split('&lt;limite_credito&gt;').last.split('&lt;/limite_credito&gt;').first.gsub(',', '.').to_f,
          available_for_withdrawal: limit_response.split('&lt;disponivel_saques&gt;').last.split('&lt;/disponivel_saques&gt;').first.gsub(',', '.').to_f,
          available_for_shopping: limit_response.split('&lt;disponivel_compras&gt;').last.split('&lt;/disponivel_compras&gt;').first.gsub(',', '.').to_f,
          balance: limit_response.split('&lt;saldo_atual&gt;').last.split('&lt;/saldo_atual&gt;').first.gsub(',', '.').to_f,
          blocked_value: limit_response.split('&lt;bloqueio_judicial&gt;').last.split('&lt;/bloqueio_judicial&gt;').first.gsub(',', '.').to_f,
          name: limit_response.split('&lt;nome&gt;').last.split('&lt;/nome&gt;').first
        })
      else
        # Returns default values for limit fields if limit call was not needed
        response.merge!({
          error: false,
          code: status_response.split("&lt;codigo_retorno&gt;").last.split("&lt;/codigo_retorno&gt;").first.to_i,
          limit: 0.0,
          available_for_withdrawal: 0.0,
          available_for_shopping: 0.0,
          balance: 0.0,
          blocked_value: 0.0,
          name: ''
        })
      end
      response
    rescue StandardError
      { error: true }
    end

    def self.change_invoice_due_date_response(response)
      binding.pry 
      begin
        xml_str = response[:alterar_vencimento_fatura_response][:return]
        codigo_retorno = xml_str.split("<codigo_retorno>").last.split("</codigo_retorno>").first.to_i
        cod_ret = xml_str.split("<cod_ret>").last.split("</cod_ret>").first.to_i
        error = (codigo_retorno.eql?(0) && cod_ret.eql?(0)) ? false : true
        error_message = error_message_for_card_due_date_change(cod_ret)
        binding.pry
        {error: error, code: codigo_retorno, cod_ret: cod_ret, error_message: error_message}
      rescue
        {error: true}
      end
    end


    def self.error_message_for_card_due_date_change(cod_ret)
      case cod_ret
      when 0
        return 'A solicitação de alteração da data de vencimento de suas faturas foi recebida com sucesso, em breve a nova data de vencimento estará em vigor. Dependendo do dia escolhido, sua próxima fatura ainda poderá vir com o vencimento anterior. '
      when 88
        return 'Código de vencimento inválido'
      # when 89
      #   return 'Não permite alteração devido quantidade de dias necessárias entre uma alteração de vencimento' isso aqui nao é validado 
      when 90
        return 'Não permite alteração devido a carência'
      when 91
        return 'Estado da conta não permite alteração'
      when 14
        return 'Não existe cartão'
      when 96
        return 'Erro de sistema'
      end
    end
  end
end
