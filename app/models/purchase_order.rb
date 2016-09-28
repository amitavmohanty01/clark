class PurchaseOrder < ApplicationRecord
  belongs_to :store
  validates_uniqueness_of :name
end
