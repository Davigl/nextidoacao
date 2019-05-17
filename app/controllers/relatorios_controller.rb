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

    respond_to do |format|
      if @relatorio.save

        @relatorio.nome_arquivo = "CEX." + current_user.instituicao.nome_relatorio_instituicao + "." + @relatorio.post_date_relatorio(@relatorio.created_at) + ".SOL"
        @relatorio.save!

        format.html { redirect_to relatorios_path, notice: 'Relatorio was successfully created.' }

      else
        format.html { render :new }
        format.json { render json: @relatorio.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @relatorio.update(relatorio_params)
        format.html { redirect_to @relatorio, notice: 'Relatorio was successfully updated.' }
        format.json { render :show, status: :ok, location: @relatorio }
      else
        format.html { render :edit }
        format.json { render json: @relatorio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @relatorio.destroy
    respond_to do |format|
      format.html { redirect_to relatorios_url, notice: 'Relatorio was successfully destroyed.' }
      format.json { head :no_content }
    end
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
