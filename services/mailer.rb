module Mailer
  extend HMote::Helpers

  def self.render(template, params = {})
    return hmote(mails_path(template), params)
  end

  def self.mails_path(template)
    return sprintf("./mails/%s.mote", template)
  end

  def self.deliver(params)
    raise ArgumentError unless params[:subject]
    raise ArgumentError unless params[:text]

    defaults = {
    }

    Malone.deliver(defaults.merge(params))
  end
end
