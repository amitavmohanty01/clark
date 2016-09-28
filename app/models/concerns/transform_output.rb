class TransformOutput
	def self.transform(store)
		{:store_name => store.name, :user_name => store.user.name}
	end

	def self.transform_po(purchase_order)
		{:store_name => purchase_order.name, :user_name => purchase_order.store.name}
	end
end