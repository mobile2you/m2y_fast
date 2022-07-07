module M2yFast
  class VirtualCardXmlBuilder

    #cadastro_cartao_virtual
    def self.request_virtual_card_xml(body)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
          <Body>
            <cadastro_cartao_virtual xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <emissor xmlns=''>#{ISSUER}</emissor>
                <produto xmlns=''>#{PRODUCT}</produto>
                <limite_credito xmlns=''>#{body[:credit_limit]}</limite_credito>
                <logo xmlns=''>#{CARD_LOGO}</logo>
                <nome_completo xmlns=''>#{body[:name]}</nome_completo>
                <nome xmlns=''>#{body[:name].split(' ').first.upcase}</nome>
                <sobrenome xmlns=''>#{body[:name].split(' ').last.upcase}</sobrenome>
                <data_nascimento xmlns=''>#{body[:birth_date]}</data_nascimento>
                <sexo xmlns=''>#{body[:gender]}</sexo>
                <estado_civil xmlns=''>#{body[:marital_status]}</estado_civil>
                <nacionalidade xmlns=''>001</nacionalidade>
                <cpf xmlns=''>#{body[:document].gsub(/[^0-9]/, '')}</cpf>
                <rg xmlns=''>#{body[:rg]}</rg>
                <orgao_emissor xmlns=''>#{body[:rg_issuer ]}</orgao_emissor>
                <estado_emissor_rg xmlns=''>#{body[:rg_state]}</estado_emissor_rg>
                <nome_pae xmlns=''>#{body[:father_name].upcase}</nome_pae>
                <nome_mae xmlns=''>#{body[:mother_name].upcase}</nome_mae>
                <rua xmlns=''>#{body[:street].upcase}</rua>
                <nro_porta xmlns=''>#{body[:number]}</nro_porta>
                <complemento xmlns=''>#{body[:complement].upcase}</complemento>
                <bairro xmlns=''>#{body[:neighborhood].upcase}</bairro>
                <cep xmlns=''>#{body[:zip].gsub(/[^0-9]/, '')}</cep>
                <cidade xmlns=''>#{body[:city].upcase}</cidade>
                <estado xmlns=''>#{body[:state]}</estado>
                <pais xmlns=''>076</pais>
                <telefone xmlns=''>#{body[:phone].gsub(/[^0-9]/, '')}</telefone>
                <telefone_comercial xmlns=''>#{body[:phone].gsub(/[^0-9]/, '')}</telefone_comercial>
                <celular xmlns=''>#{body[:mobile].gsub(/[^0-9]/, '')}</celular>
                <email xmlns=''>#{body[:email]}</email>
                <gerar_senha_activacao xmlns=''>1</gerar_senha_activacao>
                <chip xmlns=''>S</chip>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </cadastro_cartao_virtual>
        </Body>
      </Envelope>"
    end

    #segunda_via_cartao_virtual
    def self.request_aditional_virtual_card_xml(card_number, embossing_name)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
      <Body>
        <segunda_via_cartao_virtual xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>C</cod_input>
            <input xmlns=''>#{card_number}</input>
            <nome_embossado xmlns=''>#{embossing_name}</nome_embossado>
            <nome_extra xmlns=''></nome_extra>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            <chip xmlns=''>S</chip>
        </segunda_via_cartao_virtual>
        </Body>
      </Envelope>"
    end
    
    #cartao_virtual_cert
    def self.show_virtual_card_xml(card_number)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
      <Body>
        <cartao_virtual_cert xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cartao xmlns=''>#{card_number}</cartao>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
        </cartao_virtual_cert>
        </Body>
      </Envelope>"
    end
  end
end