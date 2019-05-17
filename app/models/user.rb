class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :instituicao
  has_many :cadastros
  has_many :relatorios
    
  def activate_for_authentication?
  	ativo?
  end

  def inactive_message
  	ativo? ? super : :not_ativo
  end
end
