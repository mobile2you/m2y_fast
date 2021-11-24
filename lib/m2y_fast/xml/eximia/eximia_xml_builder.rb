# frozen_string_literal: true
module M2yFast
  class EximiaXmlBuilder
    def self.get_pdf_id_body(fast_account, due_date)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <findContaDtaVenc xmlns='http://webservice.edocsystem.com.br/'>
            <id xmlns=''>#{fast_account}</id>
            <dtVenc xmlns=''>#{due_date}</dtVenc>
          </findContaDtaVenc>
        </Body>
      </Envelope>"
    end

    def self.get_pdf_body(id)
      "<Envelope xmlns='http://schemas.xmlsoap.org/soap/envelope/'>
        <Body>
          <findPDF xmlns='http://webservice.edocsystem.com.br/'>
            <id xmlns=''>#{id}</id>
          </findPDF>
        </Body>
      </Envelope>"
    end
  end
end
