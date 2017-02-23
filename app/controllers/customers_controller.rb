class CustomersController < ApplicationController

skip_before_action  :verify_authenticity_token

def show
  authenticate!
  render status: 200, json: @customer.to_json
end

def sources
  authenticate!
  source = params[:source]
  # Adds the token to the customer's sources
  begin
    @customer.sources.create({:source => source})
  rescue Stripe::StripeError => e
    render status: 402, json: {error: "Error adding token to customer: #{e.message}"}
  end
  render status: 200, json: {success: "Successfully added source."}
end

def default_source
  authenticate!
  source = params[:source]

  # Sets the customer's default source
  begin
    @customer.default_source = source
    @customer.save
  rescue Stripe::StripeError => e
    render status: 402, json: {error: "Error selecting default source: #{e.message}"}
  end
  render status: 200, json: {success: "Successfully selected default source."}
end
end
