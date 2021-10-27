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
  end
end
