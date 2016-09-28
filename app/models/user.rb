class User < ApplicationRecord
	has_many :stores, dependent: :destroy

	# Role map:
	# 0 -> Guest
	# 1 -> User
	# 2 -> Admin

	attr_accessor :password
	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :name
	validates_uniqueness_of :name

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def self.authenticate_user(username, password)
		user = User.where(name: username).first
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			return user.id
		else
			return -1
		end
	end

	def can_edit?(store)
		store.user_id == self.id or self.is_admin?
	end

	def is_admin?
		self.role == 2
	end
end
