class ChargesController < ApplicationController
    def new
    end

    def create
        @purchase_option = params[:option]
        if @purchase_option == 'plaque'
            @amount = Price.find_by(item: 'plaque').price_in_cents
            @display_amount = "$#{@amount/100}.00"
            @description = "1 plaque certificate for #{params[:gift]}"
            @redirect_path = donate_path(params[:gift])
            @message = "Your order for a plaque has been placed"
        elsif @purchase_option == 'frame'
            @amount = Price.find_by(item: 'frame').price_in_cents
            @display_amount = "$#{@amount/100}.00"
            @description = "1 frame certificate for #{params[:gift]}"
            @redirect_path = donate_path(params[:gift])
            @message = "Your order for a framed certificate has been placed"
        elsif @purchase_option == 'donate'
            @amount = params[:amount].to_i*100
            @display_amount = "$#{@amount/100}.00"
            @description = "Donation for #{params[:charity]} after #{params[:gift]}"
            @redirect_path = download_path(params[:gift])
            @message = "Your donation has been recorded. We will let you know when the donation is made."
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

    redirect_to @redirect_path, notice: @message

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to checkout_path
    end


end
