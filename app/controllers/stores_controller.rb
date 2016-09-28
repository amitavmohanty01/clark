class StoresController < ApplicationController
	def index
		render :json => {:stores => Listings.get_store_details_with_user_details}
	end

	def create
		current_user_id = current_user.id
		if current_user_id == 1
			render :json => {:error => "Create permissions are not granted to guest user."} and return
		end

		body = JSON.parse(request.body.read)
		if body['name'].blank? or body['name'].empty?
			# Here a 200 response is generated with a message about the error. Some people might prefer 4xx error codes here and the response can be
			# changed accordingly. It depends upon the contract that the service wants to establish with its clients.
			render :json => {:error => "The name can't be empty"} and return
		else
			if Store.create(:name => body['name'], :user_id => current_user_id)
				render :json => {:message => "Successully created store"} and return
			else
				render :json => {:error => "Unable to create store"} and return
			end
		end
	end

	def show
		# to_i is for protection against attacks
		store = Store.where(:id => params[:id].to_i).includes(:user).first
		if store
			render :json => TransformOutput.transform(store)
		else
			render :json => {:error => "Unable to find store"} and return
		end
	end

	def update
		update = JSON.parse(request.body.read)
		update_id = params['id'].to_i
		if update_id < 1 or update['name'].blank? or update['name'].empty?
			render :json => {:error => "Mandatory parameters missing."} and return
		end
		store = Store.where(:id => update_id).first
		if(current_user.can_edit?(store))
			store.name = update['name']
			begin
				store.save!
			rescue StandardError => e
				render :json => {:error => e.message} and return
			end
			render :json => TransformOutput.transform(store)
		else
			render :json => {:error => "You do not have Edit permissions."} and return
		end
	end

	def destroy
		id = params['id'].to_i
		store = Store.where(:id => id).first
		if store
			store.destroy!
			render :json => {:message => "Successully destroyed store"} and return
		else
			render :json => {:error => "This store is already deleted or never existed."} and return
		end
	end
end
