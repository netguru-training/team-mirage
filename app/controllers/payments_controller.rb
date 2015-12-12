class PaymentsController < ApplicationController
  expose(:project)
  expose(:payments, ancestor: :project)
  expose(:payment, attributes: :payment_params)

  def create
    payment.user = current_user

    if payment.save
      redirect_to(project_path(project))
    else
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:value)
  end
end