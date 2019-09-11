class UserMailer < ApplicationMailer
  default from: Rails.configuration.email_sender

  def verify_email(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: t('landing.welcome'))
  end

  def password_reset(user, url)
    @user = user
    @url = url
    mail to: user.email, subject: t('reset_password.subtitle')
  end

  def invitation_instructions(user, url)
    @user = user
    @site = Site.last
    @url = "https://" + url
    mail to: user.email, subject: t('invitation.subtitle')
  end
end
