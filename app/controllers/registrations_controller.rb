class RegistrationsController < Devise::RegistrationsController
	before_action :configure_sign_up_params, only: [:create]
	before_action :require_token_find, only: [:new]
	
	def new
		super
	end

	def create
		@user = User.new(user_params)
		@fabrica = FabricaUser.new()

		@fabrica.cria_usuario_admin(@user, params[:user][:token])

		redirect_to root_path
	end

	def require_token_find
		if !(Instituicao.find_token_instituicao(params[:token]))
			redirect_to root_path
		end
	end

	def configure_sign_up_params
   		 devise_parameter_sanitizer.permit(:sign_up, keys: [:login, :email, :password, :password_confirmation, :instituicao_id, @token])
  	end

	def update
		super
	end

	private 

	def user_params
		params.require(:user).permit(:login, :email, :password, :password_confirmation, :instituicao_id)
	end
end
