module M2yFast
  class LimitXmlBuilder

    # consulta_disponivel
    def self.card_limit_xml(card_id)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <consulta_disponivel xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>p</cod_input>
            <cartao xmlns=''>#{card_id}</cartao>
            <proxy xmlns=''>#{card_id}</proxy>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
          </consulta_disponivel>
        </Body>
      </Envelope>"
    end

    # alterar_limite
    def self.update_limit_xml(body)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <alterar_limite xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>p</cod_input>
            <proxy xmlns=''>#{body[:card_id]}</proxy>
            <cartao xmlns=''>#{body[:card_id]}</cartao>
            <limite xmlns=''>#{body[:credit_value]}</limite>
            <observacao xmlns=''></observacao>
            <usuario xmlns=''>#{DEFAULT_USER}</usuario>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
          </alterar_limite>
        </Body>
      </Envelope>"
    end

    # consulta_opcao_parcelamento
    def self.consult_installment_options_xml(card_id, cpf)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <consulta_opcao_parcelamento xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>p</cod_input>
            <cartao xmlns=''>#{card_id}</cartao>
            <proxy xmlns=''>#{card_id}</proxy>
            <cpf xmlns=''>#{cpf}</cpf>
            <emissor xmlns=''>#{ISSUER}</emissor>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
          </consulta_opcao_parcelamento>
        </Body>
      </Envelope>"
    end

    # gera_autorizacao
    def self.generate_authorization_xml(card_id, value, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <gera_autorizacao xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>p</cod_input>
            <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
            <trace xmlns=''>#{trace}</trace>
            <cartao xmlns=''>#{card_id}</cartao>
            <proxy xmlns=''>#{card_id}</proxy>
            <cod_operacao xmlns=''>#{DEBIT_CODE}</cod_operacao>
            <rubrica xmlns=''>#{PAYMENT_RECEIVED}</rubrica>
            <moeda xmlns=''>#{CURRENCY}</moeda>
            <valor xmlns=''>#{value}</valor>
            <usuario xmlns=''>#{DEFAULT_USER}</usuario>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
          </gera_autorizacao>
        </Body>
      </Envelope>"
    end
  end
end