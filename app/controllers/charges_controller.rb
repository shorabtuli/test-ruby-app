class ChargesController < ApplicationController

  def create

    authenticate!
  # Get the credit card details submitted by the form
  source = params[:source]

  # Create the charge on Stripe's servers - this will charge the user's card
  begin
    charge = Stripe::Charge.create(
      :amount => params[:amount], # this number should be in cents
      :currency => "usd",
      :customer => @customer.id,
      :source => source,
      :description => "Example Charge"
    )
  rescue Stripe::StripeError => e
    render status: 402, json: {error: "Error creating charge: #{e.message}"}
  end
  render status: 200, json: {success: "Charge successfully created"}
  end

  def charge_card
    # Get the credit card details submitted by the form
  token = params[:stripe_token]

  # Create the charge on Stripe's servers - this will charge the user's card
  begin
    charge = Stripe::Charge.create(
      :amount => params[:amount], # this number should be in cents
      :currency => "usd",
      :card => token,
      :description => "Example Charge"
    )
  rescue Stripe::StripeError => e
    render status: 402, json: {error: "Error creating charge: #{e.message}"}
  end
  render status: 200, json: {success: "Charge successfully created"}
  end
end
