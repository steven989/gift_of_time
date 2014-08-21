class PricesController < ApplicationController
    def update
        @price = Price.find_by(id: params[:id])
        @price.update_attributes(price_params)

        respond_to do |format|
            format.json {
                render json: {
                    message: @price.errors.full_messages.join(", "),
                    redirect_url: admin_path
                }
            }
        end
    end

    private

    def price_params
        params.require(:price).permit(:price_in_cents)
    end
end
