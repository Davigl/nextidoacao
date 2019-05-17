class RelatoriosController < ApplicationController

  layout :false
  before_action :authenticate_user!
  before_action :set_relatorio, only: [:show, :edit, :update, :destroy, :download]

  def index
    @relatorios = current_user.instituicao.relatorios.page params[:page]
  end

  def show; end

  def new
    @relatorio = Relatorio.new
  end

  def edit; end

  def create
    @relatorio = Relatorio.new(relatorio_params)
    @relatorio.user_id = current_user.id
    @relatorio.instituicao_id = current_user.instituicao.id

    if @relatorio.save
        @relatorio.nome_arquivo = "CEX." + current_user.instituicao.nome_relatorio_instituicao + "." + @relatorio.post_date_relatorio(@relatorio.created_at) + ".SOL"
        @relatorio.save!

        redirect_to relatorios_path, notice: 'Relatorio was successfully created.'
    else
      render :new
    end
  end

  def update
    if @relatorio.update(relatorio_params)
      redirect_to @relatorio, notice: 'Relatorio was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @relatorio.destroy
    redirect_to relatorios_url, notice: 'Relatorio was successfully destroyed.'
  end

  def download
    if current_user.instituicao.relatorios.where("id = ?", params[:id]).exists?
      @relatorio = current_user.instituicao.relatorios.find(params[:id])
      content = @relatorio.generate_content_file(current_user.instituicao)
      send_data(content, :filename => @relatorio.nome_arquivo)
    else
      redirect_to relatorios_path
    end
  end

  private
    def set_relatorio
      @relatorio = Relatorio.find(params[:id])
    end
    
    def relatorio_params
      params.require(:relatorio).permit(:data_inicio, :data_final, :nome_arquivo, :user_id, :instituicao_id)
    end
end
