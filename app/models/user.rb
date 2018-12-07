class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :instituicao
  has_many :cadastros
  has_many :relatorios
    
  def activate_for_authentication?
  	ativo?
  end

  def inactive_message
  	if !ativo?
  		:not_ativo
  	else
  		super
  	end
  end

end
