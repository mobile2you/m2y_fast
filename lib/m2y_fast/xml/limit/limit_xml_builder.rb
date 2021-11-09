module M2yFast
  class LimitXmlBuilder

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