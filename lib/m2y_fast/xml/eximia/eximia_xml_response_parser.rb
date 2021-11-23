# frozen_string_literal: true
module M2yFast
  class EximiaXmlResponseParser
    def self.get_pdf_id_response(json)
      if json[:find_conta_dta_venc_response][:return].present?
        json[:find_conta_dta_venc_response][:return].merge!({ error: false })
      else
        { error: false }
      end
    rescue
      { error: true }
    end
  end
end
