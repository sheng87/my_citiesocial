class CartItem
    attr_reader :sku_id, :quantity

    def initialize(sku_id, quantity = 1)
        @sku_id = sku_id
        @quantity = quantity
    end

    def increment!(n = 1)
        @quantity += n
    end

    def product
        Product.left_outer_joins(:skus).find_by(skus: { id: sku_id})
        # Sku.find(sku_id).product
    end

    def total_price 
        product.sell_price * @quantity
    end
end