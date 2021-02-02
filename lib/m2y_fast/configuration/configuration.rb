# frozen_string_literal: true

module M2yFast
  class Configuration

    attr_writer :username, :password, :cnpj, :proxy, :proxy_user, :proxy_pass, :proxy_port, :env

    def initialize #:nodoc:
      @username = nil
      @password = nil
      @cnpj = nil
      @proxy = nil
      @proxy_user = nil
      @proxy_pass = nil
    end

    def username
      @username
    end

    def password
      @password
    end

    def cnpj
      @cnpj
    end

    def proxy
      @proxy
    end

    def proxy_user
      @proxy_user
    end

    def proxy_pass
      @proxy_pass
    end

    def proxy_port
      @proxy_port
    end

    def proxy_url
      "http://#{proxy_user}:#{proxy_pass}@#{proxy}:#{proxy_port}"
    end

    def env
      @env
    end

    def wsdl
      env == "prd" ? WSDL_PRD : WSDL_HMG
    end

  end
end
