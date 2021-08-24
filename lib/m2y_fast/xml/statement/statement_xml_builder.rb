# frozen_string_literal: true
module M2yFast
  class StatementXmlBuilder

    # consulta_faturas
    def self.get_statement_xml(fast_account)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <consulta_faturas xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <emissor xmlns=''>#{ISSUER}</emissor>
                <produto xmlns=''>#{PRODUCT}</produto>
                <filial xmlns=''>#{COMPANY_BRANCH}</filial>
                <tipo_cartao xmlns=''>#{CARD_TYPE}</tipo_cartao>
                <numero_conta xmlns=''>#{fast_account}</numero_conta>
                <page xmlns=''>1</page>
                <page_length xmlns=''>100</page_length>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </consulta_faturas>
        </Body>
      </Envelope>"
    end

    # consulta_fatura_aberta
    def self.get_current_invoice_xml(fast_account)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <consulta_fatura_aberta xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <emissor xmlns=''>#{ISSUER}</emissor>
                <produto xmlns=''>#{PRODUCT}</produto>
                <filial xmlns=''>#{COMPANY_BRANCH}</filial>
                <tipo_cartao xmlns=''>#{CARD_TYPE}</tipo_cartao>
                <numero_conta xmlns=''>#{fast_account}</numero_conta>
                <page xmlns=''>1</page>
                <page_length xmlns=''>100</page_length>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </consulta_fatura_aberta>
        </Body>
      </Envelope>"
    end

    # consulta_detalhe_fatura
    def self.get_statement_detail_xml(fast_account, period)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <consulta_detalhe_fatura xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <emissor xmlns=''>#{ISSUER}</emissor>
                <produto xmlns=''>#{PRODUCT}</produto>
                <filial xmlns=''>#{COMPANY_BRANCH}</filial>
                <numero_conta xmlns=''>#{fast_account}</numero_conta>
                <periodo xmlns=''>#{period}</periodo>
                <page xmlns=''>1</page>
                <page_length xmlns=''>100</page_length>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </consulta_detalhe_fatura>
        </Body>
      </Envelope>"
    end
  end
end