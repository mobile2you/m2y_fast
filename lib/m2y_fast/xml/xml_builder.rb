# frozen_string_literal: true

module M2yFast
  class XmlBuilder

    ### CARDHOLDER ###

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

    ### CARD ###

    def self.request_card_xml(body)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
         <Body>
            <cadastro_cartao_geral xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <emissor xmlns=''>#{ISSUER}</emissor>
                <produto xmlns=''>#{PRODUCT}</produto>
                <entregadora xmlns=''>#{DELIVERER}</entregadora>
                <tipo_cartao xmlns=''>#{CARD_TYPE}</tipo_cartao>
                <cod_plastico xmlns=''>#{CARD_DESIGN}</cod_plastico>
                <cod_empregador xmlns=''>#{COMPANY_CODE}</cod_empregador>
                <nome_empregador xmlns=''>#{COMPANY}</nome_empregador>
                <matricula xmlns=''>#{body[:registration]}</matricula>
                <cargo xmlns=''>#{JOB}</cargo>
                <data_admissao xmlns=''>20150405</data_admissao>
                <salario xmlns=''>#{body[:salary].to_i}</salario>
                <limite_credito xmlns=''>#{(body[:salary] * 0.5).to_i}</limite_credito>
                <embossadora xmlns=''>#{EMBOSSING}</embossadora>
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
                <orgao_emissor_rg xmlns=''>#{body[:rg_issuer ]}</orgao_emissor_rg>
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
                <gerar_senha_ativacao xmlns=''>1</gerar_senha_ativacao>
                <tipoPlastico xmlns=''>#{PLASTIC_TYPE}</tipoPlastico>
                <proxy xmlns=''>#{body[:proxy]}</proxy>
                <cod_banco xmlns=''>#{body[:bank]}</cod_banco>
                <cod_agencia xmlns=''>#{body[:agency]}</cod_agencia>
                <cod_conta_corrente xmlns=''>#{body[:account]}</cod_conta_corrente>
                <dig_conta_corrente xmlns=''>#{body[:account_digit]}</dig_conta_corrente>
                <cod_venc_fatura xmlns=''>20</cod_venc_fatura>
                <tipo_envio_fatura xmlns=''>1</tipo_envio_fatura>
                <cnpj_correspondente xmlns=''>#{M2yFast.configuration.cnpj}</cnpj_correspondente>
                <rmc xmlns=''>#{RMC}</rmc>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </cadastro_cartao_geral>
        </Body>
      </Envelope>"
    end

    def self.register_password_xml(card_id, encrypted_password, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <cadastra_senha_cert xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <cod_input xmlns=''>p</cod_input>
                <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
                <trace xmlns=''>#{trace}</trace>
                <proxy xmlns=''>#{card_id}</proxy>
                <cartao xmlns=''>#{card_id}</cartao>
                <nova_senha xmlns=''>#{encrypted_password}</nova_senha>
                <usuario xmlns=''>#{DEFAULT_USER}</usuario>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </cadastra_senha_cert>
        </Body>
      </Envelope>"
    end

    def self.block_card_xml(card_id, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <bloqueio_cartao xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <cod_input xmlns=''>p</cod_input>
                <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
                <trace xmlns=''>#{trace}</trace>
                <proxy xmlns=''>#{card_id}</proxy>
                <cartao xmlns=''>#{card_id}</cartao>
                <status xmlns=''>#{BLOCKED_STATUS}</status>
                <usuario xmlns=''>#{DEFAULT_USER}</usuario>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </bloqueio_cartao>
        </Body>
      </Envelope>"
    end

    def self.activate_card_xml(card_id, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <ativacao_cartao xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <cod_input xmlns=''>p</cod_input>
                <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
                <trace xmlns=''>#{trace}</trace>
                <proxy xmlns=''>#{card_id}</proxy>
                <cartao xmlns=''>#{card_id}</cartao>
                <usuario xmlns=''>#{DEFAULT_USER}</usuario>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </ativacao_cartao>
        </Body>
      </Envelope>"
    end

    def self.check_card_xml(card_id, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <Retorna_Status xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <cod_input xmlns=''>p</cod_input>
                <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
                <trace xmlns=''>#{trace}</trace>
                <proxy xmlns=''>#{card_id}</proxy>
                <cartao xmlns=''>#{card_id}</cartao>
                <usuario xmlns=''>#{DEFAULT_USER}</usuario>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </Retorna_Status>
        </Body>
      </Envelope>"
    end

    def self.validate_password_xml(card_id, password, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <verifica_senha xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <cod_input xmlns=''>p</cod_input>
                <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
                <trace xmlns=''>#{trace}</trace>
                <proxy xmlns=''>#{card_id}</proxy>
                <cartao xmlns=''>#{card_id}</cartao>
                <senha xmlns=''>#{password}</senha>
                <usuario xmlns=''>#{DEFAULT_USER}</usuario>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </verifica_senha>
        </Body>
      </Envelope>"
    end

    def self.update_password_xml(card_id, new_password, old_password, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <alterar_senha xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <cod_input xmlns=''>p</cod_input>
                <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
                <trace xmlns=''>#{trace}</trace>
                <proxy xmlns=''>#{card_id}</proxy>
                <cartao xmlns=''>#{card_id}</cartao>
                <senha_atual xmlns=''>#{old_password}</senha_atual>
                <nova_senha xmlns=''>#{new_password}</nova_senha>
                <usuario xmlns=''>#{DEFAULT_USER}</usuario>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </alterar_senha>
        </Body>
      </Envelope>"
    end

    def self.check_cvv_xml(body, trace)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
            <verifica_cvv_cert xmlns='http://WSGServ/'>
                <versao xmlns=''>#{XML_VERSION}</versao>
                <cod_input xmlns=''>p</cod_input>
                <cartao xmlns=''>#{body[:card_id]}</cartao>
                <proxy xmlns=''>#{body[:card_id]}</proxy>
                <datahora xmlns=''>#{DateTime.now.strftime('%m%d%H%M%S')}</datahora>
                <trace xmlns=''>#{trace}</trace>
                <dt_validade xmlns=''>#{body[:expiration_date]}</dt_validade>
                <cvv xmlns=''>#{body[:cvv]}</cvv>
                <usuario xmlns=''>#{DEFAULT_USER}</usuario>
                <usr xmlns=''>#{M2yFast.configuration.username}</usr>
                <pwd xmlns=''>#{M2yFast.configuration.password}</pwd>
            </verifica_cvv_cert>
        </Body>
      </Envelope>"
    end

  end
end
