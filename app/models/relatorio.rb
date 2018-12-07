class Relatorio < ApplicationRecord
	paginates_per 10
	belongs_to :instituicao
	belongs_to :user

	#Function to Formater number decimal to n decimal with zeros
	#Função para formatar um numero decimal adicionando zeros
	def fnd(n, number)
		"%0#{n}d" % number
	end

	def generate_content_file(instituicao)
		@date = Time.now
		@instituicao = instituicao
		cadastros = getCadastros(@instituicao)

		generateDate = created_at.strftime("%Y%m%d")
		registroA = "A2#{fnd(2,@instituicao.codigo_produto)}#{@instituicao.nome_arquivo}#{generateDate}#{fnd(6,self.id)}" # 
		registroD = ""
		registro_total = 2
		valor_total = 0

		# D0000000012121210/17/20180000012001200000001000101
		cadastros.each do |c|
			valor = c.valor.to_i.round(2) * 100
			registroD += "\nD#{fnd(10, c.id_cliente_enel)}#{c.digito_verificador_cliente_enel}"+
								"#{fnd(2,c.codigo_ocorrencia)}#{c.data_ocorrencia.strftime('%m/%d/%Y')}"+
								"#{fnd(9,valor)}#{fnd(2, c.parcelas)}#{fnd(8,"01")}"+
								"#{fnd(4, @instituicao.codigo_produto)}#{@instituicao.codigo_instituicao}"
			registro_total +=1
			valor_total += valor
		end

		registroZ = "\nZ"+fnd(6,registro_total)+fnd(9,valor_total)
		registroA + registroD+ registroZ
	end

	def getCadastros(instituicao)
		@cadastros = instituicao.cadastros
		cadastros_relatorios = []
		@date = Time.now

		if not isDia28(@date)
			@cadastros = instituicao.cadastros.where(data_ocorrencia: (self.data_inicio)..self.data_final)
		end

		@cadastros.each do |cadastro|
			if isAdesao cadastro
				if isDia28 @date
					if cadastro.doador_ativo and cadastro.parcelas > 0
						cadastro_debito = Cadastro.new
						cadastro_debito.attributes = cadastro.attributes
						cadastro_debito.codigo_ocorrencia = '60'
						cadastro_debito.parcelas = 1
						cadastros_relatorios << cadastro_debito
						cadastro.parcelas -= 1
						cadastro.save!
					end
				else
					cadastro_debito = Cadastro.new
					cadastro_debito.attributes = cadastro.attributes
					cadastro_debito.valor = '0'
					cadastros_relatorios << cadastro_debito
					cadastro.doador_ativo = true
					cadastro.save!
				end
			else
				cadastros_relatorios << cadastro
			end
		end

		cadastros_relatorios	
	end

	def isAdesao(cadastro)
		cadastro.codigo_ocorrencia == '53'
	end

	def isDia28(date)
		date.strftime('%e').to_i == 28
	end

	def isSaturday(date)

	end
end