class UserNotifier < ActionMailer::Base
  private
  def setup_email(email)
    @recipients  = "#{email}"
    @from        = 'salva@salva.fisica.unam.mx'
    @subject     = '[SALVA] '
    @sent_on     = Time.now
  end
  
  public
  def new_notification(user,url)
    setup_email(user.email)
    @subject    += 'Su cuenta ha sido creada, por favor activela...'
    @body[:user] = user
    @body[:url]  = url
  end
  
  def activation(user,url)
    setup_email(user.email)
    @subject    += 'Su cuenta ha sido activada!'
    @body[:user] = user
    @body[:url]  = url
  end

  def forgot_password(user,url)
    setup_email(user.email)
    @subject    += 'Informaci�n para cambiar la contrase�a de su cuenta'
    @body[:user] = user
    @body[:url]  = url
  end
  
end
