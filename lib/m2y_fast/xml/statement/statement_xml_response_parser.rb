# frozen_string_literal: true
module M2yFast
  class StatementXmlResponseParser
    # consulta_faturas
    def self.get_statement_response(json)
      begin
        xml_str = json[:consulta_faturas_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        {
          error: return_code != 0,
          code: return_code,
          statement: parsed_hash.dig(:consulta_faturas, :row) || []
        }
      rescue
        { error: true }
      end
    end

    # consulta_fatura_aberta
    def self.get_current_invoice_response(json)
      begin
        xml_str = json[:consulta_fatura_aberta_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i
        invoice = parsed_hash.dig(:consulta_fatura_aberta, :row)
        invoice = invoice.last if invoice.is_a?(Array)

        {
          error: return_code != 0,
          code: return_code,
          invoice: invoice
        }
      rescue
        { error: true }
      end
    end

    # consulta_detalhe_fatura
    def self.get_statement_detail_xml_response(json)
      begin
        xml_str = json[:consulta_detalhe_fatura_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i

        {
          error: return_code != 0,
          code: return_code,
          items: parsed_hash.dig(:consulta_detalhe_fatura, :row) || []
        }
      rescue
        { error: true }
      end
    end

    # gera_boleto
    def self.get_statement_billet_xml_response(json)
      begin
        xml_str = json[:gera_boleto_response][:return]
        parsed_hash = Hash.from_xml(xml_str)['G_ServApp_Response'].deep_symbolize_keys!
        return_code = parsed_hash[:codigo_retorno].to_i
        billet = parsed_hash.dig(:gera_boleto, :row) || []
        billet = billet.first if billet.is_a?(Array)

        {
          error: return_code != 0,
          code: return_code,
          expiration_date: billet[:dt_vencimento],
          digitable_line: billet[:retorno_ld],
          value: billet[:saldo],
          minimum_payment: billet[:pgto_minimo]
        }
      rescue
        { error: true }
      end
    end
  end
end