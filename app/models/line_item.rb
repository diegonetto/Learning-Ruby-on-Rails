class LineItem < ActiveRecord::Base
  # No line item can exist unless the corresponding cart
  # and product rows exist.
  # In General:
  #     If a table contains foreign keys, the model should have
  #     a belongs_to for each.
  belongs_to :product
  belongs_to :cart
  belongs_to :order 

  def total_price
    price
  end

end
