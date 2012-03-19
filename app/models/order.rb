class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = [ "Check", "Credit Card", "Purchase order" ]

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  # Method for adding list_items in current cart to this order
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      # nil out cart_id reference so that when the cart is destroyed
      # the line_item will not be deleted
      item.cart_id = nil
      # append item to the current line_items collection for the order
      # Rails Awesomeness: Notice that we didn't have to do anything special
      #                    with the various foreign key fields. Rails does 
      #                    the magic for us using the has_many() and belongs_to()
      #                    declarations we added to the Order and LineItem models.
      #                    Appending each new item to the line_items collection hands
      #                    the responsibility for key management over to Rails.
      line_items << item
    end
  end

end
