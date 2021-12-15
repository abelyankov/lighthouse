class Product < ApplicationRecord
  validates :wildberries_id, uniqueness:{ scope: :date, message: "Should be one record per day." }
  validates_presence_of :name, :position, :date, :wildberries_id

  scope :by_wildberries_id, -> (id) {
    where(wildberries_id: id)
  }
end
