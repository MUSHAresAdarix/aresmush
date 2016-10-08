module AresMUSH
  module Cookies
    def self.give_cookie(recipient, client, giver)
      
      if (recipient == giver)
        client.emit_failure t('cookies.cant_cookie_yourself')
        return
      end
      
      if (recipient.cookies_received.include?(giver))
        client.emit_failure t('cookies.cookie_already_given', :name => recipient.name)
        return
      end
      
      CookieAward.create(giver: giver, recipient: recipient)
      
      client.emit_success t('cookies.cookie_given', :name => recipient.name)

      other_client = recipient.client
      if (other_client)
        other_client.emit_ooc t('cookies.cookie_received', :name => giver.name)
      end
      
      Global.logger.info "#{giver.name} gave #{recipient.name} a cookie."
    end
  end
end