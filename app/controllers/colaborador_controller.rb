class ColaboradorController < ApplicationController

	before_action :is_admin, only: [:new, :create]

	def new
		@user = User.new
	end

	def index
		@colaboradores = current_user.instituicao.users
	end

	def create
		@fabrica = FabricaUser.new()
		@user = User.new(user_params)
		@fabrica.cria_usuario_colaborador(@user,current_user)
		redirect_to cadastros_path
	end

	def is_admin
		if user_signed_in?
			if !(current_user.admin?)
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end

	private
	
	def user_params
		params.require(:user).permit(:login, :email, :password, :password_confirmation, :instituicao_id)
	end
end
