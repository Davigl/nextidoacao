class CadastrosController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_cadastro, only: [:show, :edit, :update, :destroy]
  layout false

  def index
    @search_query = params[:q]
    @cadastros = current_user.instituicao.cadastros.search(@search_query)
    @cadastros = @cadastros.page params[:page]
  end
  
  def show; end

  def new
    @cadastro = Cadastro.new
  end

  def edit; end

  def create
    @cadastro = Cadastro.new(cadastro_params)
    @cadastro.instituicao_id = current_user.instituicao_id
    @cadastro.user_id = current_user.id
    @cadastro.autor = current_user.login
    @cadastro.doador_ativo = false
    
    if @cadastro.save
        redirect_to @cadastro, notice: 'Cadastro was successfully created.'
    else
        render :new
    end
  end

  def update
    if @cadastro.update(cadastro_params)
      redirect_to @cadastro, notice: 'Cadastro was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cadastro.destroy
    redirect_to cadastros_url, notice: 'Cadastro was successfully destroyed.'
  end

  private
    def set_cadastro
      @cadastro = current_user.instituicao.cadastros

      if @cadastro.ids.include? params[:id].to_i
         @cadastro = @cadastro.find(params[:id])
      else
         redirect_to cadastros_path
      end
    end

    def cadastro_params
      params.require(:cadastro).permit(:id_cliente_enel, :digito_verificador_cliente_enel, :codigo_ocorrencia, :data_ocorrencia, :valor, :parcelas, :livre, :doador_ativo, :parcelas_controle, :instituicao_id, :user_id)
    end
end
