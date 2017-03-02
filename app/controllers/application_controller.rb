class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate!
  # This code simulates "loading the Stripe customer for your current session".
  # Your own logic will likely look very different.
  return @customer if @customer
  if params[:createNewUser].present?
    mobileAppCustomerID = params[:mobileAppCustomerID]
    begin
      @customer = Stripe::Customer.create(:description => mobileAppCustomerID)
    rescue Stripe::InvalidRequestError
    end
    session[:customer_id] = @customer.id

#  elsif params[:customer_id].present?
#    customer_id = params[:customer_id]
#    session[:customer_id] = customer_id
#    begin
#      @customer = Stripe::Customer.retrieve(customer_id)
#    rescue Stripe::InvalidRequestError
#    end
#  end
#  elsif session.has_key?(:customer_id)
#    customer_id = session[:customer_id]
#    begin
#      @customer = Stripe::Customer.retrieve(customer_id)
#    rescue Stripe::InvalidRequestError
#    end
#  end
  @customer
  end
end
