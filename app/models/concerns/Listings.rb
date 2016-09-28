class Listings
	# This method can be enhanced to take an optional parameter for filtering store names or user ids or may be for pagination
	def self.get_store_details_with_user_details
		h = []
		t = Store.joins(:user).includes(:user)
		t.each {|x| h << TransformOutput.transform(x)}
		return h
	end

	def self.get_po_details_with_store_name
		h = []
		t = PurchaseOrder.joins(:store).includes(:store)
		t.each {|x| h << TransformOutput.transform_po(x)}
		return h
	end
end