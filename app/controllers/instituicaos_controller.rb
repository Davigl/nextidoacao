class InstituicaosController < ApplicationController
  before_action :set_instituicao, only: [:edit, :update]
  helper_method :incrementar

  def new
    @instituicao = Instituicao.new
  end

  def create
    @instituicao = Instituicao.new(instituicao_params)
    
    if @instituicao.save
      redirect_to email_validation_path, notice: 'Instituicao was successfully created.'
      
      UserMailer.welcome_email(@instituicao).deliver_later
    else
      render :new
    end
  end

  def edit ;end

  def update
    if @instituicao.update(instituicao_params)
        redirect_to cadastros_path, notice: 'Instituicao atualizada com sucesso.'
    else
        render :edit
    end
  end

  private
    def set_instituicao
      @instituicao = current_user.instituicao
    end

    def instituicao_params
      params.require(:instituicao).permit(:nome_instituicao, :nome_relatorio_instituicao, 
        :codigo_instituicao, :codigo_produto, :logo, :cnpj, :email, :nome_arquivo, telefones_attributes: [:id, :numero, :codigo_area, :tipo],
        enderecos_attributes: [:logradouro, :tipo_logradouro, :numero, :bairro, :cidade, :estado])
    end
end
