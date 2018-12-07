class SessionsController < Devise::SessionsController

	before_action :require_activated, only: [:create]

	def new
		super
	end

	def create
		super
	end

	def destroy
		if !(current_user.ativo?)
			sign_out(resource_name)
			redirect_to user_not_actived_path
		else
			sign_out(resource_name)
			redirect_to root_path
		end
	end

	private

	def require_activated
		if user_signed_in?
			if current_user.activate_for_authentication?
				redirect_to cadastros_path
				set_flash_message :notice, :ativo
			else
				destroy
				set_flash_message :notice, :not_ativo
			end
		end
	end

end