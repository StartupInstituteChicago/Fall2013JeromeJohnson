class ReservationMailer < ActionMailer::Base
  default from: "wheezy@test.net"

  def reservation_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => 'Your reservation has been confirmed', 
      :from => 'wheezy@test.net')
  end
end
