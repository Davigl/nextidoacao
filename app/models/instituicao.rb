class Instituicao < ApplicationRecord

	before_create :add_token

	has_many :telefones, :dependent => :destroy
	has_many :enderecos, :dependent => :destroy
	has_many :users
	has_many :cadastros
	has_many :relatorios

	accepts_nested_attributes_for :telefones,  allow_destroy: true
	accepts_nested_attributes_for :enderecos, reject_if: :all_blank, allow_destroy: true

	validates_presence_of :nome_instituicao, :nome_relatorio_instituicao, :codigo_instituicao, :nome_arquivo
	validates_length_of :nome_relatorio_instituicao, :maximum => 20
	validates_length_of :codigo_produto, :maximum => 2
	validates_length_of :codigo_instituicao, :maximum => 2

	def self.find_token_instituicao(token)
    	if (Instituicao.find_by token: token) != nil
    		return true
    	end

    	return false
  	end
	
	private

	def add_token
		begin
		  self.token = SecureRandom.hex[0,10].upcase
		end while self.class.exists?(token: token)
	end
end