class Cadastro < ApplicationRecord
	belongs_to :user
	belongs_to :instituicao
	paginates_per 10

	validates_presence_of :id_cliente_enel, :digito_verificador_cliente_enel, :codigo_ocorrencia, :valor, :parcelas
	validates :id_cliente_enel, length: { maximum: 10, too_long: "é maior que o aceitável de 10 digitos." }
	validates :digito_verificador_cliente_enel, length: { maximum: 1, too_long: "é maior que o aceitável de 1 digitos." }
	validates :codigo_ocorrencia, length: { maximum: 2, too_long: "é maior que o aceitável de 2 digitos." }
	validates :parcelas, length: { maximum: 2, too_long: "é maior que o aceitável de 2 digitos." }
	validates_length_of :livre, :maximum => 42
	
	def self.search_top3_colaboradores (key)
		colaboradores = []
		cadastros = Cadastro.select("user_id,count(*)").where("instituicao_id = ?","#{key}").group("user_id")
		.order('2 desc').first(3)

		cadastros.each do |cadastro|
			colaboradores << (User.find (cadastro.user_id))
		end

		colaboradores
	end

	def self.search_top3_dashboard (key)
		cadastros = Cadastro.select("count(*),autor").where("instituicao_id = ?","#{key}").group("autor").order('2 desc').first(5).reverse
	end

	def self.search(query)
		if query.present?
			where(['id_cliente_enel::text LIKE :query OR autor::text LIKE :query', query: "%#{query}"])
		else
			all
		end
	end

end
