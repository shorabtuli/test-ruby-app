class CustomersController < ApplicationController

def show
  authenticate!
  status 200
  content_type :json
  @customer.to_json
end

def sources
  authenticate!
  source = params[:source]
  # Adds the token to the customer's sources
  begin
    @customer.sources.create({:source => source})
  rescue Stripe::StripeError => e
    status 402
    return "Error adding token to customer: #{e.message}"
  end
  status 200
  return "Successfully added source."
end

def default_source
  authenticate!
  source = params[:source]

  # Sets the customer's default source
  begin
    @customer.default_source = source
    @customer.save
  rescue Stripe::StripeError => e
    status 402
    return "Error selecting default source: #{e.message}"
  end

  status 200
  return "Successfully selected default source."
end
end
