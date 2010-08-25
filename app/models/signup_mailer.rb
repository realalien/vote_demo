class SignupMailer < ActionMailer::Base
  
  def mail(recipient, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = 'zhujiacheng@spicyhorse.com'
      @sent_on = sent_at
      @body["title"] = 'This is test title'
      @body["email"] = 'zhujiacheng@spicyhorse.com'
      @body["message"] = message
      @headers = {}
   end

end
