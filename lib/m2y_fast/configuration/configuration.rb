# frozen_string_literal: true

module M2yFast
  class Configuration

    attr_writer :username, :password, :cnpj, :proxy, :env, :wsdl

    def initialize #:nodoc:
      @username = nil
      @password = nil
      @cnpj = nil
      @proxy = nil
      @env = nil
      @wsdl = nil
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

    def env
      @env
    end

    def wsdl
      @wsdl
    end

    def production?
      env.to_s.upcase == 'PRD'
    end
  end
end
