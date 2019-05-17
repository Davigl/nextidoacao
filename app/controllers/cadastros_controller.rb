class CadastrosController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_cadastro, only: [:show, :edit, :update, :destroy]
  layout false

  # GET /cadastros
  # GET /cadastros.json

  def index
    @search_query = params[:q]
    @cadastros = current_user.instituicao.cadastros.search(@search_query)
    @cadastros = @cadastros.page params[:page]
  end

  # GET /cadastros/1
  # GET /cadastros/1.json
  def show; end

  # GET /cadastros/new
  def new
    @cadastro = Cadastro.new
  end

  # GET /cadastros/1/edit
  def edit; end

  # POST /cadastros
  # POST /cadastros.json
  def create
    @cadastro = Cadastro.new(cadastro_params)
    @cadastro.instituicao_id = current_user.instituicao_id
    @cadastro.user_id = current_user.id
    @cadastro.autor = current_user.login
    @cadastro.doador_ativo = false
    
    respond_to do |format|
      if @cadastro.save
        format.html { redirect_to @cadastro, notice: 'Cadastro was successfully created.' }
        format.json { render :show, status: :created, location: @cadastro }
      else
        format.html { render :new }
        format.json { render json: @cadastro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cadastros/1
  # PATCH/PUT /cadastros/1.json
  def update
    respond_to do |format|
      if @cadastro.update(cadastro_params)
        format.html { redirect_to @cadastro, notice: 'Cadastro was successfully updated.' }
        format.json { render :show, status: :ok, location: @cadastro }
      else
        format.html { render :edit }
        format.json { render json: @cadastro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cadastros/1
  # DELETE /cadastros/1.json
  def destroy
    @cadastro.destroy
    respond_to do |format|
      format.html { redirect_to cadastros_url, notice: 'Cadastro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cadastro
      @cadastro = current_user.instituicao.cadastros

      if @cadastro.ids.include? params[:id].to_i
         @cadastro = @cadastro.find(params[:id])
      else
         redirect_to cadastros_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cadastro_params
      params.require(:cadastro).permit(:id_cliente_enel, :digito_verificador_cliente_enel, :codigo_ocorrencia, :data_ocorrencia, :valor, :parcelas, :livre, :doador_ativo, :parcelas_controle, :instituicao_id, :user_id)
    end
end
