class DashboardController < ApplicationController
	layout false
	before_action :authenticate_user!
	
	def index
		@dashboard = Dashboard.new

		@instituicao = current_user.instituicao
		@cadastros_dia = current_user.instituicao.cadastros.where('extract(day from created_at) = ?', Date.today.day).size
		@cadastros_mes = current_user.instituicao.cadastros.select('valor').where('extract(month from data_ocorrencia) = ? AND extract(year from data_ocorrencia) = ? AND doador_ativo = ?', Date.today.month, Date.today.year, true)
		
		@ultimos_cadastros = current_user.instituicao.cadastros.last(5)
		@arrecadado = @dashboard.get_arrecadado(@cadastros_mes)
		@percentual = @dashboard.percentual(@cadastros_dia)
		@percentual_liquido = @dashboard.percentual_liquido(@arrecadado)

		@semana_values = get_semana_values
		@meses_values = get_mes_values

		@dia_mais_cadastros = @dashboard.maior_hash_key(@semana_values)[0]
		@dia_menos_cadastros = @dashboard.menor_hash_key(@semana_values)[0]
	
		@mes_mais_cadastros = @dashboard.maior_hash_key(@meses_values)[0]
		@mes_menos_cadastros = @dashboard.menor_hash_key(@meses_values)[0]
		
	end

	def get_cadastros_mes
		render json: get_mes_values, status: :ok
	end

	def get_cadastros_semana
		render json: get_semana_values, status: :ok
	end

	def get_cadastros_colaboradores
		render json: Cadastro.search_top3_dashboard(current_user.instituicao.id)
	end

	private
		def get_mes_values
			data = current_user.instituicao.cadastros
			meses = Dashboard.get_values_months(data)
			hash_values = {janeiro: meses[0], fevereiro: meses[1], marco: meses[2], abril: meses[3], maio: meses[4], 
						junho: meses[5], julho: meses[6], agosto: meses[7], setembro: meses[8], outubro: meses[9], novembro: meses[10], dezembro: meses[11]}
		end

		def get_semana_values
			data = current_user.instituicao.cadastros.select("data_ocorrencia").where('data_ocorrencia between ? and ?', Date.today.beginning_of_week, Date.today.end_of_week)
			dias = Dashboard.get_values_days(data)
			hash_values = {domingo: dias[0], segunda: dias[1], terca: dias[2], quarta: dias[3], quinta: dias[4], 
						sexta: dias[5], sabado: dias[6]}
		end

end
