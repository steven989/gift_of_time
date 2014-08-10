class ChargesController < ApplicationController
    def new
    end

    def create
        @purchase_option = params[:option]
        if @purchase_option == 'plaque'
            @amount = Price.find_by(item: 'plaque').price_in_cents
            @display_amount = "$#{@amount/100}.00"
            @description = "1 plaque certificate for #{params[:gift]}"
        elsif @purchase_option == 'frame'
            @amount = Price.find_by(item: 'frame').price_in_cents
            @display_amount = "$#{@amount/100}.00"
            @description = "1 frame certificate for #{params[:gift]}"
        end

      customer = Stripe::Customer.create(
        email: params[:email],
        card: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @amount,
        description: @description,
        currency: 'cad'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to checkout_path
    end
end
