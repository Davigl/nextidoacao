class RegistrationsColaboradoresController < Devise::RegistrationsController
	prepend_before_action :require_no_authentication, only: :cancel
	before_action :is_admin, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@fabrica = FabricaUser.new()
		@user = User.new(user_params)
		@fabrica.cria_usuario_colaborador(@user)
	end

	def is_admin
		if current_user != nil
			if !(current_user.admin?)
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end
end
