class Store < ApplicationRecord
	has_many :purchase_orders, dependent: :destroy
	belongs_to :user
	validates_uniqueness_of :name
end
