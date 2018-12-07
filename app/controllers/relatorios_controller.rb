class RelatoriosController < ApplicationController

  layout :false
  before_action :authenticate_user!
  before_action :set_relatorio, only: [:show, :edit, :update, :destroy, :download]

  # GET /relatorios
  # GET /relatorios.json
  def index
    @relatorios = current_user.instituicao.relatorios.page params[:page]
  end

  # GET /relatorios/1
  # GET /relatorios/1.json
  def show
  end

  # GET /relatorios/new
  def new
    @relatorio = Relatorio.new
  end

  # GET /relatorios/1/edit
  def edit
  end

  # POST /relatorios
  # POST /relatorios.json
  def create
    @relatorio = Relatorio.new(relatorio_params)
    @relatorio.user_id = current_user.id
    @relatorio.instituicao_id = current_user.instituicao.id

    respond_to do |format|
      if @relatorio.save

        @relatorio.nome_arquivo = "CEX." + current_user.instituicao.nome_relatorio_instituicao + "." + post_date_relatorio(@relatorio.created_at) + ".SOL"
        @relatorio.save!

        format.html { redirect_to relatorios_path, notice: 'Relatorio was successfully created.' }

      else
        format.html { render :new }
        format.json { render json: @relatorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relatorios/1
  # PATCH/PUT /relatorios/1.json
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

  # DELETE /relatorios/1
  # DELETE /relatorios/1.json
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
    # Use callbacks to share common setup or constraints between actions.


    def post_date_relatorio(data)
      data.strftime("%Y%m%d")
    end

    def set_relatorio
      @relatorio = Relatorio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relatorio_params
      params.require(:relatorio).permit(:data_inicio, :data_final, :nome_arquivo, :user_id, :instituicao_id)
    end
end
