class Api::V1::UtilsController < ApplicationController
    def subscribe
      email = params['subscribe']['email']
      sub = Subscribe.new(email: email)
  
      if sub.save
        render json: { status: 'ok', email: email }
      else
        render json: { status: 'duplicated', email: email }
      end

    end

    def cart
      product = Product.left_outer_joins(:skus).find_by(skus: { id: params[:sku]})

      if product
        current_cart.add_sku(params[:sku])
        session[:cart_9453] = current_cart.serialize

        render json: { status: 'ok', items: current_cart.items.count}
      end  
    end
  end




 