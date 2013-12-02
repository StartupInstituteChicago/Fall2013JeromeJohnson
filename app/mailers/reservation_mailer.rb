class ReservationMailer < ActionMailer::Base
  default from: "wheey@test.net"

  def reservation_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => 'Your reservation has been confirmed', 
      :from => 'wheezy@test.net')
  end
end
