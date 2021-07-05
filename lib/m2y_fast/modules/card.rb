module M2yFast

  require "savon"
  require 'digest/md5'

  class Card

    def self.get_client
      Savon.client(
        wsdl: M2yFast.configuration.wsdl,
        log: true,
        proxy: M2yFast.configuration.proxy_url,
        log_level: :debug,
        pretty_print_xml: true,
        open_timeout: 15,
        read_timeout: 15
      )
    end

    def self.request_card(body)
      client = get_client
      body[:registration] = Time.now.to_i
      body[:proxy] = body[:registration].to_s
      xml = XmlBuilder.request_card_xml(body)
      response = client.call(:cadastro_cartao_geral, xml: xml)
      XmlResponseParser.request_card_response(response.body, body)
    end

    def self.register_password(card_id, encrypted_password)
      client = get_client
      xml = XmlBuilder.register_password_xml(card_id, encrypted_password, trace)
      response = client.call(:cadastra_senha_cert, xml: xml)
      XmlResponseParser.register_password_response(response.body)
    end

    def self.block_card(card_id)
      client = get_client
      xml = XmlBuilder.block_card_xml(card_id, trace)
      response = client.call(:bloqueio_cartao, xml: xml)
      XmlResponseParser.block_card_response(response.body)
    end

    def self.validate_password(card_id, password)
      client = get_client
      xml = XmlBuilder.validate_password_xml(card_id, password, trace)
      response = client.call(:verifica_senha, xml: xml)
      XmlResponseParser.validate_password_response(response.body)
    end

    def self.update_password(card_id, new_password, old_password)
      client = get_client
      xml = XmlBuilder.validate_password_xml(card_id, new_password, old_password, trace)
      response = client.call(:alterar_senha, xml: xml)
      XmlResponseParser.update_password_response(response.body)
    end

    def self.activate_card(card_id)
      client = get_client
      xml = XmlBuilder.activate_card_xml(card_id, trace)
      response = client.call(:ativacao_cartao, xml: xml)
      XmlResponseParser.activate_card_response(response.body)
    end

    def self.check_card(card_id)
      client = get_client
      xml = XmlBuilder.check_card_xml(card_id, trace)
      response = client.call(:retorna_status, xml: xml)
      XmlResponseParser.check_card_response(response.body)
    end

    def self.check_cvv(body)
      client = get_client
      xml = XmlBuilder.check_cvv_xml(body, trace)
      response = client.call(:verifica_cvv_cert, xml: xml)
      XmlResponseParser.check_cvv_response(response.body)
    end

    def self.trace
      rand(100000..999999)
    end
  end
end
