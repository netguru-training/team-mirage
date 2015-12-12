class PaymentsController < ApplicationController
  expose(:payment)

  def create
    if payment.save
      redirect_to(payment)
    else
      render :new
    end
  end
end