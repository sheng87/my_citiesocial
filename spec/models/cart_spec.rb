require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new } 

  context "基本功能" do 
    it "商品丟到購物籃，購物車有東西" do
      cart.add_sku(2)
 
      expect(cart).not_to be_empty
    end
    it "加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變。" do 
      3.times { cart.add_sku(1) }
      2.times { cart.add_sku(2) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3 
    end
    it "商品可以放到購物車裡，也可以再拿出來。"do 
      p1 = create(:product, :with_skus)

      cart.add_sku(p1.skus.first.id)

      expect(cart.items.first.product).to be_a Product
    end

    it "可以計算整台購物車的總消費金額" do
      p1 = create(:product, :with_skus, sell_price: 8)
      p2 = create(:product, :with_skus, sell_price: 7)

      3.times { cart.add_sku(p1.skus.firstid) }
      2.times { cart.add_sku(p2.skus.first.id) }

      expect(cart.total_price).to eq 38
  end

    describe "if the date is Dec 25th" do
      before do
        Timecop.freeze(Time.local(2019, 12, 25))
      end
    
      after do
        Timecop.return
      end
    
      it "特別活動可搭配折扣（例如聖誕節的時候全面打 5 折)" do 
        p1 = create(:product,:with_skus, sell_price: 8)
        p2 = create(:product,:with_skus, sell_price: 7)
  
        3.times { cart.add_sku(p1.skus.first.id) }
        2.times { cart.add_sku(p2.skus.first.id) }
        
        expect(Timecop.freeze(Time.local(2019, 12, 25))).to eq Time.now
        expect(cart.merry_christmas).to eq 19
    end 
  end  
end  

  context "進階功能" do 
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡" do 
      p1 = create(:product, :with_skus)
      p2 = create(:product, :with_skus)

      3.times { cart.add_sku(p1.id) }
      2.times { cart.add_sku(p2.id) }

      expect(cart.serialize).to eq cart_hash
    end

    it "也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容"do 
      cart = Cart.from_hash(cart_hash)

      expect(cart.items.first.quantity).to be 3
    end

    private 

    def cart_hash 
      {
        "items" => [
          {"sku_id" => 1, "quantity" => 3},
          {"sku_id" => 2, "quantity" => 2}
        ]
      }
    end
  end
end
