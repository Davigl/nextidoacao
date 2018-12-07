class ColaboradorController < ApplicationController

	before_action :authenticate_user!
	before_action :is_admin, only: [:new, :create]
	before_action :set_colaborador, only: [:show, :update, :edit]
	layout :false
	
	def new
		@user = User.new
	end

	def index
		@colaboradores = current_user.instituicao.users.last(5)
		@colaboradores_top3 = Cadastro.search_top3_colaboradores(current_user.instituicao.id)
	end

	def create
		@fabrica = FabricaUser.new()
		@user = User.new(user_params)
		@fabrica.cria_usuario_colaborador(@user,current_user)
		redirect_to cadastros_path
	end

	def show; end

	def edit; end

	def update
		if @user.update(user_params)
			redirect_to cadastros_path, notice: 'Colaborador atualizado com sucesso.'
		else
			render :edit
		end
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
	
	def set_colaborador
		@user = current_user
	end

	def user_params
		params.require(:user).permit(:login, :email, :password, :password_confirmation, :instituicao_id)
	end
end
