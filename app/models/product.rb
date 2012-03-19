class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items

  # Call a hook method before deleting row from database
  # If hook method returns false, row will not be destroyed
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :title, length: { 
    minimum: 10, 
    too_short: 'must be at least 10 characters long.'
  }
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private

    # Hook method called by before_destroy
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        # Associate this error with the base object itself
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
