class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@annieherieau.fr"
  # default from: "annie.herieau@gmail.com"
  layout "mailer"
end
