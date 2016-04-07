class ApplicationMailer < ActionMailer::Base
  default from: "noreply@social-wiki.herokuapp.com"
  layout 'mailer'
end
