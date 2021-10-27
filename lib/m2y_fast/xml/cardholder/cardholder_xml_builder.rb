# frozen_string_literal: true
module M2yFast
  class CardholderXmlBuilder

    # consulta_portador
    def self.get_cardholder_xml(body)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <consulta_portador xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>p</cod_input>
            <cartao xmlns=''>#{body[:card_id]}</cartao>
            <proxy xmlns=''>#{body[:card_id]}</proxy>
            <cpf xmlns=''>#{body[:cpf]}</cpf>
            <senha xmlns=''>#{body[:password]}</senha>
            <emissor xmlns=''>#{ISSUER}</emissor>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
          </consulta_portador>
        </Body>
      </Envelope>"
    end

    # dados_gral_portador
    def self.get_user_registration_xml(card_id)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <dados_gral_portador xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>p</cod_input>
            <proxy xmlns=''>#{card_id}</proxy>
            <cartao xmlns=''>#{card_id}</cartao>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
          </dados_gral_portador>
        </Body>
      </Envelope>"
    end

    # alteracao_portador2
    def self.update_user_registration_xml(body)
      registration = body[:registration].blank? ? Time.now.to_i : body[:registration]
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <alteracao_portador2 xmlns='http://WSGServ/'>
            <versao xmlns=''>#{XML_VERSION}</versao>
            <cod_input xmlns=''>p</cod_input>
            <cartao xmlns=''>#{body[:card_id]}</cartao>
            <proxy xmlns=''>#{body[:card_id]}</proxy>
            <codigo_cliente xmlns=''></codigo_cliente>
            <nome_completo xmlns=''>#{body[:name]}</nome_completo>
            <nome xmlns=''>#{body[:name].split(' ').first.upcase}</nome>
            <sobrenome xmlns=''>#{body[:name].split(' ').last.upcase}</sobrenome>
            <data_nascimento xmlns=''>#{body[:birth_date]}</data_nascimento>
            <sexo xmlns=''>#{body[:gender]}</sexo>
            <estado_civil xmlns=''>#{body[:marital_status]}</estado_civil>
            <nacionalidade xmlns=''>001</nacionalidade>
            <cpf xmlns=''>#{body[:document].gsub(/[^0-9]/, '')}</cpf>
            <rg xmlns=''>#{body[:rg]}</rg>
            <orgao_emissor_rg xmlns=''>#{body[:rg_issuer]}</orgao_emissor_rg>
            <estado_emissor_rg xmlns=''>#{body[:rg_state]}</estado_emissor_rg>
            <nome_pai xmlns=''>#{body[:father_name].upcase}</nome_pai>
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
            <usuario xmlns=''>#{DEFAULT_USER}</usuario>
            <banco xmlns=''></banco>
            <agencia xmlns=''></agencia>
            <numero_conta xmlns=''></numero_conta>
            <nome_empregador xmlns=''>#{COMPANY}</nome_empregador>
            <cod_empregador xmlns=''>#{COMPANY_CODE}</cod_empregador>
            <matricula xmlns=''>#{registration}</matricula>
            <cargo xmlns=''>#{JOB}</cargo>
            <data_admissao xmlns=''>20150405</data_admissao>
            <salario xmlns=''>#{body[:salary].to_i}</salario>
            <usr xmlns=''>#{M2yFast.configuration.username}</usr>
            <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
          </alteracao_portador2>
        </Body>
      </Envelope>"
    end
  end
end
