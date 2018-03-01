class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
  layout 'mailer'

  def order_email(order)
    @order = order
    @url  = "http://example.com/login"
    mail(to: @order.email, subject: "Jungle Receipt , @order.id")
  end
end
